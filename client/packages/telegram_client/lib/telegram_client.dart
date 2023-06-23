import 'dart:async';

import 'package:logging/logging.dart';
import 'package:td_json_client/td_api.dart';

import 'telegram_client_interface.dart';
import 'db_isolated.dart';
import 'td_client.dart';
import 'ingester_contract.dart';
import 'wrap_id.dart';

class TelegramClient implements TelegramClientInterface {
  final Logger logger;

  late final TdClient tdClient;

  TelegramClient(this.logger, String libtdjsonlcPath, Level logLevelLibTdJson,
      Uri? proxyUri) {
    tdClient = TdClient(
      logger,
      libtdjsonlcPath,
      logLevelLibTdJson,
      proxyUri,
    );
  }

  Future<void> close() async {
    await tdClient.close();
  }

  Future<void> login(LoginParams loginParams) async {
    logger.info('loging in...');

    var isAuthorized = false;
    var exception;

    var sub = tdClient.tdEvents.stream
        .where((event) => event is UpdateAuthorizationState)
        .listen((event) async {
      final authorizationState = event.authorization_state;
      logger.info('received ${authorizationState.runtimeType}.');

      try {
        if (authorizationState is AuthorizationStateWaitTdlibParameters) {
          await _setTdlibParameters(loginParams);
        } else if (authorizationState is AuthorizationStateWaitPhoneNumber) {
          await _setAuthenticationPhoneNumber(loginParams);
        } else if (authorizationState is AuthorizationStateWaitCode) {
          await _checkAuthenticationCode(loginParams);
        } else if (authorizationState
            is AuthorizationStateWaitOtherDeviceConfirmation) {
          loginParams.writeQrCodeLink(authorizationState.link ?? '');
        } else if (authorizationState is AuthorizationStateWaitRegistration) {
          await _registerUser(loginParams);
        } else if (authorizationState is AuthorizationStateWaitPassword) {
          await _checkAuthenticationPassword(loginParams);
        } else if (authorizationState is AuthorizationStateReady) {
          isAuthorized = true;
        }
      } on Object catch (ex) {
        exception = ex;
      }
    });

    logger.info('sending GetAuthorizationState...');
    tdClient.tdSend(GetAuthorizationState());

    while (true) {
      if (isAuthorized || exception != null) break;
      await Future.delayed(const Duration(milliseconds: 100));
    }
    sub.cancel();

    if (exception != null) throw exception;

    logger.info('login success.');
  }

  Future<void> saveChatsHistory(DateTime dateTimeFrom,
      IngesterContractParams ingesterContractParams, DbIsolated db) async {
    logger.info('reading groups history... ');

    final ingesterContract = IngesterContract(logger, ingesterContractParams);
    final chatsNames = (await ingesterContract.getChatsNames())
        .where((element) => element.isNotEmpty)
        .toList();

    logger.info('adding groups to db...');
    await db.insertChats(chatsNames);

    var chatIndex = 0;
    var chatCount = chatsNames.length;
    for (final chatName in chatsNames) {
      chatIndex++;
      logger.info('[$chatName] chat index $chatIndex from $chatCount.');
      logger.info('[$chatName] reading group history...');
      try {
        await _saveChatHistory(dateTimeFrom, chatName, db);
      } on TgChatNotFoundException catch (ex) {
        logger.warning('[$chatName] $ex.');
        await db.blacklistChat(chatName, ex.message ?? 'Group not found');
      } on TgTimeOutException catch (ex) {
        logger.warning('[$chatName] $ex.');
      } on TgMaxRetriesExcedeedException catch (ex) {
        logger.warning('[$chatName] $ex.');
      } on TgBadRequestException catch (ex) {
        logger.severe('[$chatName] $ex.');
      } on UnWrapIdxception catch (ex) {
        logger.warning('[$chatName] $ex.');
      } on TgErrorCodeNotHandledException catch (ex) {
        logger.severe('[$chatName] $ex.');
      } on TgException catch (ex) {
        logger.severe('[$chatName] $ex.');
      }

      await Future.delayed(const Duration(
          seconds: TelegramClientConfig.delayUntilNextChatSeconds));
    }
  }

  Future<Message> readChatMessage(String chatName, int messageId) async {
    final chat = await _searchPublicChat(chatName);
    final chatId = WrapId.unwrapChatId(chat.id);
    logger.info('[$chatName] unwrapped chat id is $chatId.');

    return await tdClient.retryTdCall(
      GetMessage(
        chat_id: chat.id,
        message_id: WrapId.wrapMessageId(messageId),
      ),
    ) as Message;
  }

  Future<TdObject> _setTdlibParameters(LoginParams loginParams) async {
    logger.info('sending SetTdlibParameters...');
    return await tdClient.retryTdCall(SetTdlibParameters(
      api_id: loginParams.apiId,
      api_hash: loginParams.apiHash,
      database_directory: loginParams.databasePath,
      use_message_database: true,
      device_model: 'Desktop',
      application_version: '1.0',
      system_language_code: 'en',
      database_encryption_key: '',
    ));
  }

  Future<TdObject> _setAuthenticationPhoneNumber(
      LoginParams loginParams) async {
    logger.info('sending SetAuthenticationPhoneNumber...');
    return await tdClient.retryTdCall(SetAuthenticationPhoneNumber(
      phone_number: loginParams.phoneNumber,
    ));
  }

  Future<TdObject> _checkAuthenticationCode(LoginParams loginParams) async {
    logger.info('sending CheckAuthenticationCode...');
    return await tdClient.retryTdCall(CheckAuthenticationCode(
      code: loginParams.readTelegramCode(),
    ));
  }

  Future<TdObject> _registerUser(LoginParams loginParams) async {
    logger.info('sending RegisterUser...');
    return await tdClient.retryTdCall(RegisterUser(
      first_name: loginParams.readUserFirstName(),
      last_name: loginParams.readUserLastName(),
    ));
  }

  Future<TdObject> _checkAuthenticationPassword(LoginParams loginParams) async {
    logger.info('sending CheckAuthenticationPassword...');
    return await tdClient.retryTdCall(CheckAuthenticationPassword(
      password: loginParams.readUserPassword(),
    ));
  }

  Future<void> _saveChatHistory(
      DateTime dateTimeFrom, String chatName, DbIsolated db) async {
    var chatId = 0;

    final chatInfo = await db.selectChat(chatName);
    if (chatInfo != null) {
      if (chatInfo['blacklisted'] == 1) {
        logger.info('[$chatName] blacklisted, skipping...');
        return;
      }
      chatId = chatInfo['id'] ?? 0;
    }

    if (chatId == 0) {
      final chat = await _searchPublicChat(chatName);
      chatId = WrapId.unwrapChatId(chat.id);
      logger.info('[$chatName] unwrapped chat id is $chatId.');
      await db.updateChat(chatName, chat);
    }

    await _openChat(chatName, chatId);
    await Future.delayed(const Duration(seconds: 2));

    final supergroupFullInfo = await _getSupergroupFullInfo(chatName, chatId);
    await _updateChatMembersCount(chatName, chatId, db, supergroupFullInfo);

    final subscriptionOnlineMemberCount =
        _subscribeUpdateChatOnlineMemberCount(chatName, chatId, db);

    if (supergroupFullInfo.can_get_members == true)
      await _updateChatBotsCount(chatName, chatId, db);

    await _closeChat(chatName, chatId);

    await subscriptionOnlineMemberCount.cancel();

    final onlineMembersCount = await db.selectChatOnlineMembersCount(chatName);

    while (true) {
      final messageIdLast =
          await _findMessageIdLast(chatName, chatId, dateTimeFrom, db) ?? 0;
      final messageIdFrom = messageIdLast + 1;

      final history = await _getChatHistory(chatName, chatId, messageIdFrom);
      final messages = history.messages;
      if (messages == null || messages.length == 0) break;

      await _saveMessagesUsers(
          chatName, chatId, messages, onlineMembersCount, db);

      if (messages.length < TelegramClientConfig.getChatHistoryLimit) break;

      await Future.delayed(const Duration(
        seconds: TelegramClientConfig.delayUntilNextMessageBatchSeconds,
      ));
      break;
    }
  }

  Future<Chat> _searchPublicChat(String chatName) async {
    logger.info('[$chatName] searching public chat... ');
    try {
      final Chat chat = await tdClient.retryTdCall(SearchPublicChat(
        username: chatName,
      )) as Chat;

      if (chat.id == null) {
        throw TgChatNotFoundException('Chat.id is null');
      } else if (chat.type == null) {
        throw TgChatNotFoundException('Chat.type is null');
      } else if (!(chat.type is ChatTypeSupergroup)) {
        throw TgChatNotFoundException('Invalid Chat.type: '
            '${chat.type.runtimeType}');
      }

      return chat;
    } on TgBadRequestException catch (ex) {
      throw TgChatNotFoundException(ex.toString());
    }
  }

  Future<void> _updateChatMembersCount(String chatName, int chatId,
      DbIsolated db, SupergroupFullInfo supergroupFullInfo) async {
    final memberCount = supergroupFullInfo.member_count;
    if (memberCount != null && memberCount != 0) {
      logger.info('[$chatName] member count is $memberCount.');
      await db.updateChatMembersCount(chatName, memberCount);
    }
  }

  Future<SupergroupFullInfo> _getSupergroupFullInfo(
      String chatName, int chatId) async {
    logger.info('[$chatName] reading supergroup full info... ');
    return await tdClient.retryTdCall(GetSupergroupFullInfo(
      supergroup_id: chatId,
    )) as SupergroupFullInfo;
  }

  Future<void> _updateChatBotsCount(
      String chatName, int chatId, DbIsolated db) async {
    final chatMembersBots = await _getSupergroupMembers(
        chatName, chatId, SupergroupMembersFilterBots());
    final bots = chatMembersBots.members;
    if (bots != null) {
      final botsCount = bots.length;
      logger.info('[$chatName] bot count is $botsCount.');
      await db.updateChatBotsCount(chatName, botsCount);
    }
  }

  Future<ChatMembers> _getSupergroupMembers(
    String chatName,
    int chatId, [
    SupergroupMembersFilter? supergroupMembersFilter,
  ]) async {
    logger.info('[$chatName] reading supergroup members... ');
    return await tdClient.retryTdCall(GetSupergroupMembers(
      supergroup_id: chatId,
      filter: supergroupMembersFilter,
      offset: 0,
      limit: 200,
    )) as ChatMembers;
  }

  StreamSubscription<dynamic> _subscribeUpdateChatOnlineMemberCount(
      String chatName, int chatId, DbIsolated db) {
    return tdClient.tdEvents.stream
        .where((event) =>
            event is UpdateChatOnlineMemberCount &&
            event.chat_id == WrapId.wrapChatId(chatId))
        .listen((event) {
      final updateChatOnlineMemberCount = event as UpdateChatOnlineMemberCount;
      final onlineMemberCount = updateChatOnlineMemberCount.online_member_count;
      if (onlineMemberCount != null && onlineMemberCount != 0) {
        logger.info('[$chatName] online member count is $onlineMemberCount.');
        db.updateChatMembersOnlineCount(chatName, onlineMemberCount);
      }
    });
  }

  Future<void> _openChat(String chatName, int chatId) async {
    logger.info('[$chatName] opening chat... ');
    await tdClient.retryTdCall(OpenChat(chat_id: WrapId.wrapChatId(chatId)));
  }

  Future<void> _closeChat(String chatName, int chatId) async {
    logger.info('[$chatName] closing chat... ');
    await tdClient.retryTdCall(CloseChat(chat_id: WrapId.wrapChatId(chatId)));
  }

  Future<int?> _findMessageIdLast(
      String chatName, int chatId, DateTime dateTimeFrom, DbIsolated db) async {
    logger.fine('[$chatName] searching last local message...');
    final messageIdLastLocal =
        await db.selectMaxMessageIdFromDate(chatId, dateTimeFrom);
    if (messageIdLastLocal != null) {
      logger.fine('[$chatName] found local message id $messageIdLastLocal');
      return messageIdLastLocal;
    }

    logger.fine('[$chatName] searching last remote message...');
    final messageIdLastRemote =
        await _searchMessageIdLastRemote(chatName, chatId, dateTimeFrom);
    if (messageIdLastRemote != null) {
      logger.fine('[$chatName] found remote message id $messageIdLastRemote');
      return messageIdLastRemote;
    }

    return null;
  }

  Future<int?> _searchMessageIdLastRemote(
    String chatName,
    int chatId,
    DateTime datetimeFrom,
  ) async {
    logger.info('[$chatName] searching last remote message...');
    try {
      final message =
          await _getChatMessageByDate(chatName, chatId, datetimeFrom);
      return WrapId.unwrapMessageId(message.id);
    } on TgNotFoundException {
    } on UnWrapIdxception {}

    return null;
  }

  Future<Message> _getChatMessageByDate(
      String chatName, int chatId, DateTime datetimeFrom) async {
    logger.info('[$chatName] getting chat message by date... ');
    return await tdClient.retryTdCall(GetChatMessageByDate(
      chat_id: WrapId.wrapChatId(chatId),
      date: datetimeFrom.millisecondsSinceEpoch ~/ 1000,
    )) as Message;
  }

  Future<Messages> _getChatHistory(
    String chatName,
    int chatId,
    int messageIdFrom,
  ) async {
    logger.info('[$chatName] getting chat history from $messageIdFrom... ');
    return await tdClient.retryTdCall(GetChatHistory(
      chat_id: WrapId.wrapChatId(chatId),
      from_message_id: WrapId.wrapMessageId(messageIdFrom),
      offset: -TelegramClientConfig.getChatHistoryLimit,
      limit: TelegramClientConfig.getChatHistoryLimit,
      only_local: false,
    )) as Messages;
  }

  Future<void> _saveMessagesUsers(String chatName, int chatId,
      List<Message> messages, int? onlineMembersCount, DbIsolated db) async {
    final msgs = <Message>[];
    final users = <int, User>{};

    for (final Message message in messages) {
      if (message.chat_id == null || message.id == null || message.date == null)
        continue;
      msgs.add(message);

      if (message.sender_id == null) continue;
      if (message.sender_id is! MessageSenderUser) continue;
      final userId = (message.sender_id as MessageSenderUser).user_id;
      if (userId == null) continue;

      final userExists = await db.userExists(userId);
      if (userExists) continue;

      if (users.containsKey(userId)) continue;

      final user = await _getUser(userId);
      users[userId] = user;

      await Future.delayed(const Duration(
          seconds: TelegramClientConfig.delayUntilNextUserSeconds));
    }

    if (msgs.length == 0) return;

    await db.insertMessagesUsers(
        messages, users.values.toList(), onlineMembersCount);

    var info = '[$chatName] saved ${msgs.length} messages';
    if (users.length > 0) info += ', ${users.length} users';
    info += '.';
    logger.info(info);
  }

  Future<User> _getUser(int userId) async {
    return await tdClient.retryTdCall(GetUser(
      user_id: userId,
    )) as User;
  }
}

class TelegramClientConfig {
  static const int delayUntilNextChatSeconds = 10;
  static const int delayUntilNextMessageBatchSeconds = 5;
  static const int delayUntilNextUserSeconds = 2;

  static const int getChatHistoryLimit = 99;
}

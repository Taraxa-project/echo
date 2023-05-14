import 'dart:async';

import 'package:logging/logging.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:td_json_client/td_api.dart';
import 'package:telegram_client/ref/db_isolated.dart';

import 'tg_interface.dart';
import 'td_client.dart';
import 'ingester_contract.dart';
import 'package:telegram_client/wrap_id.dart';

class Tg implements TgInterface {
  final Logger logger;
  final DbIsolated db;
  late final TdClient tdClient;
  late final IngesterContract ingesterContract;

  static const int delayUntilNextChatSeconds = 10;
  static const int delayUntilNextMessageBatchSeconds = 5;
  static const int delayUntilNextUserSeconds = 2;

  Tg(
    this.logger,
    this.db,
    String libtdjsonlcPath,
    Level logLevelLibTdJson,
    Uri? proxyUri,
    IngesterContractParams ingesterContractParams,
  ) {
    tdClient = TdClient(
      logger,
      libtdjsonlcPath,
      logLevelLibTdJson,
      proxyUri,
    );
    ingesterContract = IngesterContract(
      logger,
      ingesterContractParams,
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

  Future<TdObject> _setTdlibParameters(LoginParams loginParams) async {
    logger.info('sending SetTdlibParameters...');
    return await tdClient.retryTdCall(SetTdlibParameters(
      api_id: loginParams.apiId,
      api_hash: loginParams.apiHash,
      database_directory: loginParams.databasePath,
      use_message_database: false,
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

  Future<void> saveChatsHistory(DateTime dateTimeFrom) async {
    logger.info('reading groups history... ');

    final chatsNames = await ingesterContract.getChatsNames();

    logger.info('adding groups to db...');
    await db.insertChats(chatsNames);

    for (final chatName in chatsNames) {
      logger.info('[$chatName] reading group history...');
      try {
        await _saveChatHistory(dateTimeFrom, chatName);
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

      logger.info('reading groups history... '
          'sleeping for $delayUntilNextChatSeconds seconds.');
      await Future.delayed(const Duration(seconds: delayUntilNextChatSeconds));
      break;
    }
  }

  Future<void> _saveChatHistory(DateTime dateTimeFrom, String chatName) async {
    final chat = await _searchPublicChat(chatName);
    final chatId = WrapId.unwrapChatId(chat.id);
    logger.info('[$chatName] unwrapped chat id is $chatId.');

    await db.updateChat(chatName, chat);

    await _updateChatMembersCount(chatName, chatId);
    final subscriptionOnlineMemberCount =
        _subscribeUpdateChatOnlineMemberCount(chatName, chatId);
    await _openChat(chatName, chatId);
    await _updateChatBotsCount(chatName, chatId);
    await _closeChat(chatName, chatId);
    await subscriptionOnlineMemberCount.cancel();

    final onlineMembersCount = await db.selectChatOnlineMembersCount(chatName);

    while (true) {
      final messageIdLast =
          await _findMessageIdLast(chatName, chatId, dateTimeFrom) ?? 0;
      final messageIdFrom = messageIdLast + 1;

      final history = await _getChatHistory(chatName, chatId, messageIdFrom);
      final messages = history.messages;
      if (messages == null || messages.length == 0) break;

      await _saveMessages(chatName, chatId, messages, onlineMembersCount);
      await _saveUsersFromMessages(chatName, messages);

      logger.info('[$chatName] '
          'sleeping for $delayUntilNextMessageBatchSeconds seconds.');
      await Future.delayed(const Duration(
        seconds: delayUntilNextMessageBatchSeconds,
      ));
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

  Future<void> _updateChatMembersCount(String chatName, int chatId) async {
    final supergroupFullInfo = await _getSupergroupFullInfo(chatName, chatId);
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

  Future<void> _updateChatBotsCount(String chatName, int chatId) async {
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
    String chatName,
    int chatId,
  ) {
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
    String chatName,
    int chatId,
    DateTime dateTimeFrom,
  ) async {
    logger.info('[$chatName] searching last local message...');
    final messageIdLastLocal =
        await db.selectMaxMessageIdFromDate(chatId, dateTimeFrom);
    if (messageIdLastLocal != null) {
      logger.info('[$chatName] found local message id $messageIdLastLocal');
      return messageIdLastLocal;
    }

    logger.info('[$chatName] searching last remote message...');
    final messageIdLastRemote =
        await _searchMessageIdLastRemote(chatName, chatId, dateTimeFrom);
    if (messageIdLastRemote != null) {
      logger.info('[$chatName] found remote message id $messageIdLastRemote');
      return messageIdLastRemote;
    }

    return null;
  }

  Future<int?> _searchMessageIdLastRemote(
    String chatName,
    int chatId,
    DateTime datetimeFrom,
  ) async {
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
      offset: -99,
      limit: 99,
      only_local: false,
    )) as Messages;
  }

  Future<void> _saveMessages(
    String chatName,
    int chatId,
    List<Message> messages,
    int? onlineMemberCount,
  ) async {
    var messagesCount = 0;

    for (Message message in messages) {
      if (message.chat_id == null || message.id == null || message.date == null)
        continue;
      db.insertMessage(message, onlineMemberCount);
      messagesCount += 1;
    }

    logger.info('[$chatName] saved ${messagesCount} messages.');
  }

  Future<void> _saveUsersFromMessages(
    String chatName,
    List<Message> messages,
  ) async {
    var userCount = 0;

    for (var message in messages) {
      if (message.sender_id == null) continue;
      if (message.sender_id is! MessageSenderUser) continue;

      int? userId = (message.sender_id as MessageSenderUser).user_id;
      if (userId == null) continue;

      try {
        await db.insertUser(userId);
      } on SqliteException catch (ex) {
        // Unique constraint
        if (ex.resultCode == 19 && ex.extendedResultCode == 2067) continue;
        rethrow;
      }

      var user = await _getUser(userId);
      await db.updateUser(userId, user);
      userCount++;

      await Future.delayed(const Duration(seconds: delayUntilNextUserSeconds));
    }

    if (userCount > 0) {
      logger.info('[$chatName] saved $userCount users.');
    }
  }

  Future<User> _getUser(int userId) async {
    return await tdClient.retryTdCall(GetUser(
      user_id: userId,
    )) as User;
  }

  DateTime _twoWeeksAgo() {
    final dateTimeTwoWeeksAgo =
        DateTime.now().toUtc().subtract(const Duration(days: 14));
    return DateTime(dateTimeTwoWeeksAgo.year, dateTimeTwoWeeksAgo.month,
        dateTimeTwoWeeksAgo.day);
  }
}

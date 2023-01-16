import 'dart:io';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:args/command_runner.dart';

import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/client.dart';
import 'package:telegram_client/listener/login_listener.dart';
import 'package:telegram_client/listener/get_chat_message_by_date_listener.dart';
import 'package:telegram_client/listener/search_public_chat_listener.dart';
import 'package:telegram_client/listener/get_chat_history_listener.dart';
import 'package:telegram_client/db/db.dart';
import 'package:telegram_client/wrap_id.dart';
import 'package:echo_cli/callback/cli.dart';
import 'package:telegram_client/lg.dart';

class TelegramCommandMessages extends Command {
  final name = 'messages';
  final description = 'Read and save messages from the last two weeks.';

  final Logger _logger = Logger('Messages');

  TelegramClient? telegramClient;

  Db? db;

  void run() async {
    initLogging();
    
    final Lg _lg = Lg();
    await _lg.spawn();
    initDB(_lg);



    // db?..open()
    //   ..migrate();
    // await Future.delayed(Duration(seconds: 3));

    // var chatIds = await db?.selectChats();
    // print('chatids ${chatIds}');
    // // await db?.selectChats();
    // var parsedDate = DateTime.parse('2022-01-01');
    // await Future.delayed(Duration(seconds: 3));

    // var maxId = await db?.selectMaxMessageId(1176547813, parsedDate);
    // print("🚀 ~ file: messages.dart:51 ~ TelegramCommandMessages ~ voidrun ~ maxId ${maxId}");


    // await db?.addMessage(chatId: 1176547813,
    //                 messageId: 123456789, 
    //                 date: 1673610624,
    //                 userId: 47829382,
    //                 text: "test message");



  
    // await db?.addChat('usernametest');

    // await Future.delayed(Duration(seconds: 3));

    // exit(0);

    initClient();

    await login();
    await seachPublicChats();
    await readChatsHistory();

    await closeClient();
    closeDB();
  }

  List<string> getChatsNames() {
    var chatsNamesDecoded;

    try {
      chatsNamesDecoded = jsonDecode(globalResults!.command!['chats-names']);
    } on FormatException {
      invalidInputChats();
    }

    if (chatsNamesDecoded.runtimeType != List || chatsNamesDecoded.isEmpty) {
      invalidInputChats();
    }

    List<String> chatsNames = [];
    for (var chatNameDecoded in chatsNamesDecoded) {
      if (chatNameDecoded.runtimeType != string) {
        invalidInputChats();
      }
      chatsNames.add(chatNameDecoded);
    }
    return chatsNames;
  }

  void invalidInputChats() {
    print("The option \"charts-names\" must be a valid "
        "JSON encoded list of strings.");
    exit(1);
  }

  void initLogging() {
    _logger.level = getLogLevel();
    _logger.onRecord.listen((event) {
      print(event);
    });
  }

  void initClient() {
    telegramClient = TelegramClient(
      libtdjsonlcPath: globalResults!['libtdjson-path'],
    )
      ..waitTimeout = 5.0
      ..readEventsFrequency = Duration(milliseconds: 50)
      ..setupLogs(
        logger: Logger('TelegramClient')
          ..level = getLogLevel()
          ..onRecord.listen((event) {
            // print(event);
          }),
        loggerTdLib: Logger('Libtdjson')
          ..level = getLogLevelLibtdjson()
          ..onRecord.listen((event) {
            print(event);
          }),
      );
  }

  void initDB(Lg _lg) async {
    db = Db(dbPath: globalResults!['message-database-path']);
    await db?.spawn(lg: _lg);
    db?..open()
      ..migrate();
  }

  Future<void> closeClient() async {
    await telegramClient?.exit();
  }

  void closeDB() async {
    await db?.close();
  }

  Future<void> login() async {
    var login = LoginListener(
      setTdlibParameters: SetTdlibParameters(
        api_id: int.parse(globalResults!['api-id']),
        api_hash: globalResults!['api-hash'],
        database_directory: globalResults!['database-path'],
        use_message_database: false,
        device_model: 'Desktop',
        application_version: '1.0',
        system_language_code: 'en',
        database_encryption_key: '',
      ),
      setAuthenticationPhoneNumber: SetAuthenticationPhoneNumber(
        phone_number: globalResults!['phone-number'],
      ),
      checkAuthenticationCodeWithCallback: CheckAuthenticationCodeWithCallback(
        readTelegramCode: readTelegramCode,
      ),
      authorizationStateWaitOtherDeviceConfirmationWithCallback:
          AuthorizationStateWaitOtherDeviceConfirmationWithCallback(
        writeQrCodeLink: writeQrCodeLink,
      ),
      registerUserWithCallback: RegisterUserWithCallback(
        readUserFirstName: readUserFirstName,
        readUserLastName: readUserLastName,
      ),
      checkAuthenticationPasswordWithCallback:
          CheckAuthenticationPasswordWithCallback(
              readUserPassword: readUserPassword),
      telegramSender: telegramClient,
      logger: Logger('Login')
        ..level = getLogLevel()
        ..onRecord.listen((event) {
          print(event);
        }),
    );

    telegramClient?.addEventListener(
      login,
      filter: LoginListener.isLoginEvent,
    );
    if (!await login.auth()) {
      exit(-1);
    }

    await telegramClient?.removeEventListener(login);
    login.exit();
  }

  Future<void> seachPublicChats() async {
    for (String chatName in getChatsNames()) {
      await searchPublicChat(chatName);
    }
  }

  Future<void> searchPublicChat(String chatName) async {
    var searchPublicChat = SearchPublicChatListener(
      telegramSender: telegramClient,
      db: db,
      username: chatName,
      logger: Logger('SearchPublicChat')
        ..level = getLogLevel()
        ..clearListeners()
        ..onRecord.listen((event) {
          print(event);
        }),
    );
    telegramClient?.addEventListener(
      searchPublicChat,
      filter: SearchPublicChatListener.isChat,
    );
    await searchPublicChat.search_public_chat();

    await telegramClient?.removeEventListener(searchPublicChat);
    searchPublicChat.exit();
  }

  Future<void> readChatsHistory() async {
    _logger.info('selecting chats locally...');
    var chatsIds = await db?.selectChats() ?? [];
    _logger.info('found ${chatsIds.length} chats locally.');
    for (int id in chatsIds) {
      await readChatHistory(id);
    }
  }

  Future<void> readChatHistory(int chatId) async {
    var twoWeeksAgo = computeTwoWeeksAgo();
    _logger.info('[$chatId] reading chat history '
        'from ${twoWeeksAgo.toIso8601String()}...');

    _logger.info('[$chatId] finding last message id...');
    var messageIdLast = await getMessageIdLast(chatId, twoWeeksAgo);
    messageIdLast += 1;

    while (true) {
      var getChatHistory = GetChatHistoryListener(
        telegramSender: telegramClient,
        logger: Logger('GetChatHistoryListener')
          ..level = getLogLevel()
          ..clearListeners()
          ..onRecord.listen((event) {
            print(event);
          }),
        chatId: chatId,
      );

      telegramClient?.addEventListener(getChatHistory);

      await getChatHistory.get_chat_history(
        from_message_id: messageIdLast,
        offset: -99,
        limit: 99,
        only_local: false,
      );

      await telegramClient?.removeEventListener(getChatHistory);
      getChatHistory.exit();

      if (getChatHistory.messages == null ||
          getChatHistory.messages?.messages == null ||
          getChatHistory.messages!.messages!.length == 0) {
        break;
      }

      int messageCount = 0;
      for (Message message in getChatHistory.messages!.messages!) {
        if (message.chat_id == null ||
            message.id == null ||
            message.date == null) {
          continue;
        }

        var userId = null;
        if (message.sender_id != null &&
            message.sender_id.runtimeType == MessageSenderUser) {
          userId = (message.sender_id as MessageSenderUser).user_id;
        }

        var text = null;
        if (message.content != null &&
            message.content.runtimeType == MessageText) {
          var formattedText = (message.content as MessageText).text;
          if (formattedText != null) {
            text = formattedText.text;
          }
        }

        await db?.addMessage(
            chatId: WrapId.unwrapChatId(message.chat_id)!,
            messageId: WrapId.unwrapMessageId(message.id)!,
            date: message.date!,
            userId: userId,
            text: text);
        messageCount += 1;

        var messageIdLastNew = WrapId.unwrapMessageId(message.id)!;
        if (messageIdLastNew > messageIdLast) {
          messageIdLast = messageIdLastNew;
        }
      }
      _logger.info('[$chatId] added $messageCount messages to db.');

      messageIdLast += 1;
    }
    _logger.info('[$chatId] done reading chat history '
        'from ${twoWeeksAgo.toIso8601String()}.');
  }

  Future<int> getMessageIdLast(int chatId, DateTime twoWeeksAgo) async {
    _logger.info('[$chatId] reading last message id locally...');
    var messageIdLast = await getMessageIdLastLocally(chatId, twoWeeksAgo);

    if (messageIdLast == null) {
      _logger.info('[$chatId] did not find last message id locally.');
      _logger.info('[$chatId] reading last message id remotely...');
      messageIdLast = await getMessageIdLastRemote(chatId, twoWeeksAgo);
    }

    if (messageIdLast == null) {
      _logger.info('[$chatId] did not find last message id remotely.');
      messageIdLast = 0;
    }

    _logger.info('[$chatId] last message id is $messageIdLast.');
    return messageIdLast;
  }

  Future<int?> getMessageIdLastLocally(int chatId, DateTime newerThan) async {
    var maxId;
    await db?.selectMaxMessageId(chatId, newerThan).then((messageId) {
      print("received max message id ${messageId}");
      maxId = messageId;
    });
    return maxId;
  }

  Future<int?> getMessageIdLastRemote(int chatId, DateTime olderThan) async {
    var getChatMessageByDate = GetChatMessageByDateListener(
      telegramSender: telegramClient,
      logger: Logger('GetChatMessageByDate')
        ..level = getLogLevel()
        ..clearListeners()
        ..onRecord.listen((event) {
          print(event);
        }),
      chatId: chatId,
    );

    telegramClient?.addEventListener(getChatMessageByDate);
    await getChatMessageByDate.get_chat_message_by_date(
      date: olderThan,
    );

    await telegramClient?.removeEventListener(getChatMessageByDate);
    getChatMessageByDate.exit();

    return getChatMessageByDate.messageId;
  }

  DateTime computeTwoWeeksAgo() {
    return DateTime.now().subtract(const Duration(days: 14));
  }

  Level getLogLevel() {
    return getLogLevelByName(globalResults!['loglevel']);
  }

  Level getLogLevelLibtdjson() {
    return getLogLevelByName(globalResults!['libtdjson-loglevel']);
  }

  Level getLogLevelByName(String name) {
    return Level.LEVELS.firstWhere(
      (level) => level.name == name.toUpperCase(),
      orElse: () => Level.WARNING,
    );
  }
}

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

class TelegramCommandMessages extends Command {
  final name = 'messages';
  final description = 'Read and save messages from the last two weeks.';

  final Logger logger = Logger('messages');
  final loggerTdLib = Logger("tdlib");

  TelegramClient? telegramClient;

  DB? db;

  void run() async {
    initLoggers();
    initDB();
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

  void initLoggers() {
    logger.level = getLogLevel();
    logger.onRecord.listen((event) {
      print(event);
    });
    loggerTdLib.level = getLogLevelLibtdjson();
    loggerTdLib.onRecord.listen((event) {
      print(event);
    });
  }

  void initClient() {
    telegramClient = TelegramClient(
      libtdjsonlcPath: globalResults!['libtdjson-path'],
    );
    telegramClient?.setupLogs(logger, loggerTdLib);

    telegramClient?.waitTimeout = 5.0;
    telegramClient?.readEventsFrequency = Duration(milliseconds: 50);
  }

  void initDB() {
    db = DB(
      dbPath: globalResults!['message-database-path'],
      logger: logger,
    );
    db?.open();
    db?.migrate();
  }

  Future<void> closeClient() async {
    await telegramClient?.exit();
  }

  void closeDB() {
    db?.close();
  }

  Future<void> login() async {
    var login = await LoginListener(
      setTdlibParameters: SetTdlibParameters(
        parameters: TdlibParameters(
          api_id: int.parse(globalResults!['api-id']),
          api_hash: globalResults!['api-hash'],
          database_directory: globalResults!['database-path'],
          use_message_database: false,
          device_model: 'Desktop',
          application_version: '1.0',
          system_language_code: 'en',
        ),
      ),
      checkDatabaseEncryptionKey: CheckDatabaseEncryptionKey(
        encryption_key: '',
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
    );

    telegramClient?.addEventListener(login, filter: LoginListener.isLoginEvent);
    login.auth();

    await Future.delayed(const Duration(seconds: 20));
    telegramClient?.removeEventListener(login);

    await Future.delayed(const Duration(seconds: 5));
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
    );
    telegramClient?.addEventListener(searchPublicChat);
    searchPublicChat.search_public_chat();

    await Future.delayed(const Duration(seconds: 15));
    telegramClient?.removeEventListener(searchPublicChat);
    await Future.delayed(const Duration(seconds: 5));
    searchPublicChat.exit();
  }

  Future<void> readChatsHistory() async {
    for (int id in db?.selectChats() ?? []) {
      await readChatHistory(id);
    }
  }

  Future<void> readChatHistory(int chatId) async {
    var twoWeeksAgo = computeTwoWeeksAgo();
    var messageIdLast = await getMessageIdLast(chatId, twoWeeksAgo);

    while (true) {
      var getChatHistory = GetChatHistoryListener(
        telegramSender: telegramClient,
      );
      telegramClient?.addEventListener(getChatHistory);
      getChatHistory.get_chat_history(
        chat_id: WrapId.wrapChatId(chatId),
        from_message_id: WrapId.wrapMessageId(messageIdLast),
        offset: -99,
        limit: 99,
        only_local: false,
      );

      await Future.delayed(const Duration(seconds: 25));
      telegramClient?.removeEventListener(getChatHistory);

      await Future.delayed(const Duration(seconds: 15));
      getChatHistory.exit();

      if (getChatHistory.messages == null ||
          getChatHistory.messages?.messages == null ||
          getChatHistory.messages!.messages!.length == 0) {
        break;
      }

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

        db?.addMessage(
            chatId: WrapId.unwrapChatId(message.chat_id)!,
            messageId: WrapId.unwrapMessageId(message.id)!,
            date: message.date!,
            userId: userId,
            text: text);

        var messageIdLastNew = WrapId.unwrapMessageId(message.id)!;
        if (messageIdLastNew > messageIdLast) {
          messageIdLast = messageIdLastNew;
        }
      }

      messageIdLast += 1;
    }
  }

  Future<int> getMessageIdLast(int chatId, DateTime twoWeeksAgo) async {
    var messageIdLast = getMessageIdLastLocally(chatId, twoWeeksAgo);
    if (messageIdLast == null) {
      messageIdLast = await getMessageIdLastRemote(chatId, twoWeeksAgo);
    }
    if (messageIdLast == null) {
      messageIdLast = 1;
    }
    return messageIdLast;
  }

  int? getMessageIdLastLocally(int chatId, DateTime newerThan) {
    return db?.selectMaxMessageId(chatId, newerThan);
  }

  Future<int?> getMessageIdLastRemote(int chatId, DateTime olderThan) async {
    var getChatMessageByDate = GetChatMessageByDateListener(
      telegramSender: telegramClient,
    );
    telegramClient?.addEventListener(getChatMessageByDate);
    getChatMessageByDate.get_chat_message_by_date(
      chat_id: WrapId.wrapChatId(chatId),
      date: olderThan,
    );

    await Future.delayed(const Duration(seconds: 15));
    telegramClient?.removeEventListener(getChatMessageByDate);

    await Future.delayed(const Duration(seconds: 15));
    getChatMessageByDate.exit();

    return WrapId.unwrapMessageId(getChatMessageByDate.messageId);
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

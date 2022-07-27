import 'package:telegram_client/client.dart';
import 'package:telegram_client/get_chats.dart';
import 'package:telegram_client/new_messages.dart';
import 'package:telegram_client/port.dart';

import 'base.dart';

class TelegramCommandExample extends TelegramCommand {
  final name = 'example';
  final description = 'Login a Telegram account.';

  void run() async {
    // ---------------

    var telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
    );
    await telegramClient.initPorts(isolated: true);

    // ---------------

    await doLogin(globalResults, telegramClient.sendPort);

    // ---------------

    var getChatList = GetChatList();
    await getChatList.initPorts(isolated: true);
    getChatList.sendMessage(Subscribe(telegramClient.sendPort));
    getChatList.sendMessage(ListChats(limit: 100));

    await Future.delayed(const Duration(seconds: 5));
    getChatList.sendMessage(Unsubscribe());
    await Future.delayed(const Duration(seconds: 2));
    await getChatList.exit();

    // ---------------

    var newMessages = NewMessages();
    await newMessages.initPorts();
    newMessages.sendMessage(Subscribe(telegramClient.sendPort));
    newMessages.sendMessage(ReadNewMessages());

    var newMessagesIsolated = NewMessages();
    await newMessagesIsolated.initPorts(isolated: true);
    newMessagesIsolated.sendMessage(Subscribe(telegramClient.sendPort));
    newMessagesIsolated.sendMessage(ReadNewMessages());

    await Future.delayed(const Duration(seconds: 30));
    newMessages.sendMessage(Unsubscribe());
    await Future.delayed(const Duration(seconds: 2));
    await newMessages.exit();
    newMessagesIsolated.sendMessage(Unsubscribe());
    await Future.delayed(const Duration(seconds: 2));
    await newMessagesIsolated.exit();

    // ---------------

    await Future.delayed(const Duration(seconds: 5));
    print('Ending...');
    telegramClient.closePorts();

    // ---------------
  }
}

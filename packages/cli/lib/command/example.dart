import 'package:telegram_client/client.dart';
import 'package:telegram_client/get_chats.dart';
import 'package:telegram_client/new_messages.dart';

import 'base.dart';

class TelegramCommandExample extends TelegramCommand {
  final name = 'example';
  final description = 'Login a Telegram account.';

  void run() async {
    var telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
    );
    await telegramClient.initPortsIsolate();

    // ---------------

    await doLogin(globalResults, telegramClient.sendPort);

    // ---------------

    var getChatList = GetChatList();
    await getChatList.initPortsIsolate();
    getChatList.sendPort?.send(ListChats(
      telegramClientSendPort: telegramClient.sendPort,
      limit: 100,
    ));
    await Future.delayed(const Duration(seconds: 5));
    await getChatList.exit();

    // ---------------

    var newMessages = NewMessages();
    await newMessages.initPorts();
    newMessages.sendPort?.send(ReadNewMessages(
      telegramClientSendPort: telegramClient.sendPort,
    ));

    var newMessagesIsolated = NewMessages();
    await newMessagesIsolated.initPortsIsolate();
    newMessagesIsolated.sendPort?.send(ReadNewMessages(
      telegramClientSendPort: telegramClient.sendPort,
    ));

    await Future.delayed(const Duration(seconds: 60));
    await newMessages.exit();
    await newMessagesIsolated.exit();

    // ---------------

    await Future.delayed(const Duration(seconds: 5));
    print('Ending...');
    telegramClient.closePorts();
  }
}

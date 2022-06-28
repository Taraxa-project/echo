import 'package:echo_cli/src/tg/command/base.dart';
import 'package:echo_cli/src/tg/command/runner.dart';

import 'package:telegram_client/client.dart';

class TelegramCommandsMessages extends TelegramCommand {
  final name = 'messages';
  final description = 'Listen for new messages from a subscribed chat.';

  void run() async {
    setLogLevel(globalResults!['loglevel']);

    final TelegramClient telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
      apiId: int.parse(globalResults!['api-id']),
      apiHash: globalResults!['api-hash'],
      phoneNumber: globalResults!['phone-number'],
      libtdjsonLoglevel: int.parse(globalResults!['libtdjson-loglevel']),
      databasePath: globalResults!['database-path'],
      loglevel: globalResults!['loglevel'],
    );

    var clientId = telegramClient.createClientId();
    await telegramClient.login(
        clientId: clientId,
        readTelegramCode:
            (this.runner as TelegramCommandRunner).readTelegramCode);

    if (!telegramClient.isAuthorized) {
      print('Could not login to Telegram.');
      return;
    }

    await for (var response in telegramClient.getMessages(clientId: clientId)) {
      print(response);
    }
  }
}

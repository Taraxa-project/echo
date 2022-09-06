import 'package:echo_cli/src/tg/command/base.dart';
import 'package:echo_cli/src/tg/command/runner.dart';

import 'package:telegram_client/client.dart';

class TelegramCommandsChats extends TelegramCommand {
  final name = 'chats';
  final description = 'List the chats for a Telegram account.';

  void run() async {
    final TelegramClient telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
      apiId: int.parse(globalResults!['api-id']),
      apiHash: globalResults!['api-hash'],
      phoneNumber: globalResults!['phone-number'],
      databasePath: globalResults!['database-path'],
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

    await for (var response in telegramClient.getChats(clientId: clientId)) {
      print(response);
    }
  }
}

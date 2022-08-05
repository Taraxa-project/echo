import 'package:echo_cli/src/tg/command/base.dart';
import 'package:echo_cli/src/tg/command/runner.dart';

import 'package:telegram_client/client.dart';

class TelegramCommandLogin extends TelegramCommand {
  final name = 'login';
  final description = 'Login a Telegram account.';

  void run() async {
    final telegramClient = TelegramClient(
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

    if (telegramClient.isAuthorized) {
      print('Signed up successfully.');
    }
    if (telegramClient.isClosed) {
      print('Server closed connection.');
    }
  }
}

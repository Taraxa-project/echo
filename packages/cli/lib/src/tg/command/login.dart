import 'package:logging/logging.dart';

import 'package:telegram_client/client.dart';

import 'package:echo_cli/src/tg/command/base.dart';
import 'package:echo_cli/src/tg/command/runner.dart';

class TelegramCommandLogin extends TelegramCommand {
  final name = 'login';
  final description = 'Login a Telegram account.';

  void run() async {
    final telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
      apiId: int.parse(globalResults!['api-id']),
      apiHash: globalResults!['api-hash'],
      phoneNumber: globalResults!['phone-number'],
      databasePath: globalResults!['database-path'],
    );

    final logger = Logger("cli");
    logger.level = Level.ALL;
    logger.onRecord.listen((event) {
      print(event);
    });
    final loggerTdLib = Logger("tdlib");
    loggerTdLib.level = Level.ALL;
    loggerTdLib.onRecord.listen((event) {
      print(event);
    });

    telegramClient.setupLogs(logger, loggerTdLib);

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

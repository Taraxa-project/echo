import 'package:echo_cli/src/tg/tg_command.dart';
import 'package:echo_cli/src/tg/tg_command_runner.dart';

import 'package:telegram_client/telegram_client.dart';

class CommandSignup extends TelegramCommand {
  final name = 'signup';
  final description = 'Sign up a Telegram account.';

  void run() async {
    initLogger();

    final TelegramClient telegramClient = TelegramClient(
        libtdjsonPath: globalResults!['libtdjson-path'],
        apiId: int.parse(globalResults!['api-id']),
        apiHash: globalResults!['api-hash'],
        phoneNumber: globalResults!['phone-number'],
        libtdjsonLoglevel: int.parse(globalResults!['libtdjson-loglevel']));

    await telegramClient
        .signUp((this.runner as TelegramCommandRunner).readTelegramCode);
    if (telegramClient.isAuthorized) {
      loggy.info('Signed up successfully.');
    }
    if (telegramClient.isClosed) {
      loggy.warning('Server closed connection.');
    }
  }
}

import 'package:echo_cli/src/tg/tg_command.dart';
import 'package:echo_cli/src/tg/tg_command_runner.dart';

import 'package:telegram_client/telegram_client.dart';

class TelegramCommandsChats extends TelegramCommand {
  final name = 'chats';
  final description = 'List the chats for a Telegram account.';

  void run() async {
    initLogger();

    final TelegramClient telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
      apiId: int.parse(globalResults!['api-id']),
      apiHash: globalResults!['api-hash'],
      phoneNumber: globalResults!['phone-number'],
      libtdjsonLoglevel: int.parse(globalResults!['libtdjson-loglevel']),
      databasePath: globalResults!['database-path'],
    );

    await telegramClient
        .signUp((this.runner as TelegramCommandRunner).readTelegramCode);
    if (!telegramClient.isAuthorized) {
      print('Could not login to Telegram.');
      return;
    }

    await for (var response in telegramClient.getChats()) {
      print(response);
    }
  }
}

import 'package:telegram_client/client.dart';

import 'base.dart';

class TelegramCommandLogin extends TelegramCommand {
  final name = 'login';
  final description = 'Login a Telegram account.';

  void run() async {
    var telegramClient = await TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
    );
    await telegramClient.initPorts(isolated: true);

    await doLogin(globalResults, telegramClient.sendPort);

    await Future.delayed(const Duration(seconds: 5));
    print('Ending...');
    telegramClient.closePorts();
  }
}

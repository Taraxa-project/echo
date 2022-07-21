import 'package:telegram_client/client.dart';
import 'package:telegram_client/login.dart';

import 'base.dart';

class TelegramCommandLogin extends TelegramCommand {
  final name = 'login';
  final description = 'Login a Telegram account.';

  void run() async {
    var telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
    );
    await telegramClient.initPortsIsolate();

    buildLogin(globalResults);

    await login.initPortsIsolate();
    login.sendPort?.send(AuthenticateAccount(
      telegramClientSendPort: telegramClient.sendPort,
    ));

    await Future.delayed(const Duration(seconds: 5));
    print('Ending...');
    login.closePorts();
    telegramClient.closePorts();
  }
}

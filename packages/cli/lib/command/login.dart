import 'base.dart';

import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/client.dart';
import 'package:telegram_client/login.dart';

import '../callback/cli.dart';

class TelegramCommandLogin extends TelegramCommand {
  final name = 'login';
  final description = 'Login a Telegram account.';

  void run() async {
    var telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
    );
    await telegramClient.initPortsIsolate();

    var login = await Login(
      setTdlibParameters: SetTdlibParameters(
        parameters: TdlibParameters(
          api_id: int.parse(globalResults!['api-id']),
          api_hash: globalResults!['api-hash'],
          database_directory: globalResults!['database-path'],
          use_message_database: false,
          device_model: 'Desktop',
          application_version: '1.0',
          system_language_code: 'en',
        ),
      ),
      checkDatabaseEncryptionKey: CheckDatabaseEncryptionKey(
        encryption_key: '',
      ),
      setAuthenticationPhoneNumber: SetAuthenticationPhoneNumber(
        phone_number: globalResults!['phone-number'],
      ),
      checkAuthenticationCodeWithCallback: CheckAuthenticationCodeWithCallback(
        readTelegramCode: readTelegramCode,
      ),
      authorizationStateWaitOtherDeviceConfirmationWithCallback:
          AuthorizationStateWaitOtherDeviceConfirmationWithCallback(
        writeQrCodeLink: writeQrCodeLink,
      ),
      registerUserWithCallback: RegisterUserWithCallback(
        readUserFirstName: readUserFirstName,
        readUserLastName: readUserLastName,
      ),
      checkAuthenticationPasswordWithCallback:
          CheckAuthenticationPasswordWithCallback(
              readUserPassword: readUserPassword),
    );
    login.initPorts();
    login.sendPort?.send(AuthenticateAccount(
      telegramClientSendPort: telegramClient.sendPort,
    ));
    // login.auth(telegramClientSendPort: telegramClient.sendPort);

    await Future.delayed(const Duration(seconds: 20));
    login.exit();
    telegramClient.exit();
  }
}

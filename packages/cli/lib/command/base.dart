import 'dart:isolate';

import 'package:args/command_runner.dart';
import 'package:loggy/loggy.dart';

import 'package:telegram_client/login.dart';

import '../callback/cli.dart';
import 'package:td_json_client/td_json_client.dart';

mixin TelegramCommandLoggy implements LoggyType {
  @override
  Loggy<TelegramCommandLoggy> get loggy =>
      Loggy<TelegramCommandLoggy>('Echo - $runtimeType');

  void setLogLevel(String logLevelName) {
    loggy.level = LogOptions(LogLevel.values.firstWhere(
        (element) => element.name == logLevelName,
        orElse: () => LogLevel.all));
  }
}

abstract class TelegramCommand extends Command with TelegramCommandLoggy {
  late final Login login;
  buildLogin(dynamic globalResults) {
    login = Login(
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
  }

  Future<void> doLogin(
    dynamic globalResults,
    SendPort? telegramSendPort,
  ) async {
    buildLogin(globalResults);

    await login.initPortsIsolate();
    login.sendPort?.send(AuthenticateAccount(
      telegramClientSendPort: telegramSendPort,
    ));
    await Future.delayed(const Duration(seconds: 5));
    await login.exit();
  }
}

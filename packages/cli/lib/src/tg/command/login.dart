import 'package:echo_cli/src/tg/command/base.dart';

import 'package:telegram_client/client.dart';
import 'package:telegram_client/request/login.dart';
import 'package:td_json_client/td_json_client.dart';
import 'package:echo_cli/src/tg/input/cli.dart';

class TelegramCommandLogin extends TelegramCommand {
  final name = 'login';
  final description = 'Login a Telegram account.';

  void run() async {
    setLogLevel(globalResults!['loglevel']);

    final telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
      libtdjsonLoglevel: int.parse(globalResults!['libtdjson-loglevel']),
      loglevel: globalResults!['loglevel'],
    );

    await telegramClient.send(LoginRequest(
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
      checkAuthenticationCode: CheckAuthenticationCodeCallback(
        readTelegramCode: readTelegramCode,
      ),
    ));
  }
}

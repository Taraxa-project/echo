import 'base.dart';

import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/client.dart';
import 'package:telegram_client/login.dart';
import 'package:telegram_client/get_chats.dart';
import 'package:telegram_client/new_messages.dart';

import '../callback/cli.dart';

class TelegramCommandExample extends TelegramCommand {
  final name = 'example';
  final description = 'Multiple isolates example.';

  void run() async {
    var telegramClient = await TelegramClient.create(
      libtdjsonPath: globalResults!['libtdjson-path'],
    );

    var login = await Login.create(
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

    login.subscribe(isolatedPublisher: telegramClient);

    var getChats = await GetChatList.create();
    getChats.subscribe(isolatedPublisher: telegramClient);

    var newMessages = await NewMessages.create();
    newMessages.subscribe(isolatedPublisher: telegramClient);
  }
}

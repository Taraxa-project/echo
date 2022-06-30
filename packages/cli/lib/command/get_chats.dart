import 'dart:io';

import 'package:td_json_client/td_json_client.dart';

import 'package:telegram_client/client.dart';
import 'package:telegram_client/api/login.dart';
import 'package:telegram_client/api/get_chats.dart';

import 'base.dart';

import '../callback/cli.dart';

class TelegramCommandsGetChats extends TelegramCommand {
  final name = 'get-chats';
  final description = 'List the chats for a Telegram account.';

  void run() async {
    setLogLevel(globalResults!['loglevel']);

    final telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
      libtdjsonLoglevel: int.parse(globalResults!['libtdjson-loglevel']),
      loglevel: globalResults!['loglevel'],
    );

    var loginResponse = await telegramClient.send(LoginRequest(
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
    )) as LoginResponse;

    if (loginResponse.isClosed) {
      print('Tdlib closed.');
      exit(1);
    }

    var getChatsResponse = await telegramClient.send(GetChatsRequest(
        getChats: GetChats(
      limit: 100,
    ))) as GetChatsResponse;

    await for (var chat in getChatsResponse.chats) {
      print(chat);
    }
  }
}

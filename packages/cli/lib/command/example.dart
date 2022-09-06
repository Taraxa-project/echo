import 'package:td_json_client/td_json_client.dart';

import 'package:telegram_client/client.dart';
import 'package:telegram_client/login.dart';
import 'package:telegram_client/get_chats_info.dart';
import 'package:telegram_client/new_messages.dart';
import 'package:echo_cli/callback/cli.dart';

import 'base.dart';

class TelegramCommandExample extends TelegramCommand {
  final name = 'example';
  final description = 'Login a Telegram account.';

  void run() async {
    // var telegramClient = TelegramClient(
    //   libtdjsonPath: globalResults!['libtdjson-path'],
    // );
    var telegramClient = await TelegramClient.isolate(
      libtdjsonlcPath: globalResults!['libtdjson-path'],
    );
    var login = await Login.isolate(
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
      telegramSender: telegramClient,
    );

    telegramClient.addEventListener(login, filter: Login.isLoginEvent);
    login.auth();

    await Future.delayed(const Duration(seconds: 5));
    telegramClient.removeEventListener(login);
    await Future.delayed(const Duration(seconds: 3));
    login.exit();

    // -------------------

    var getChats = await GetChatsInfo.isolate(telegramSender: telegramClient);

    telegramClient.addEventListener(
      getChats,
      filter: GetChatsInfo.isChatInfoEvent,
    );
    getChats.listChats(limit: 100);

    await Future.delayed(const Duration(seconds: 10));
    telegramClient.removeEventListener(getChats);
    await Future.delayed(const Duration(seconds: 3));
    getChats.exit();

    // -------------------

    var newMessages = NewMesssages();
    telegramClient.addEventListener(
      newMessages,
      filter: NewMesssages.isUpdateNewMessageEvent,
    );
    var newMessagesIsolated = await NewMesssages.isolate();
    telegramClient.addEventListener(
      newMessagesIsolated,
      filter: NewMesssages.isUpdateNewMessageEvent,
    );

    await Future.delayed(const Duration(seconds: 120));
    telegramClient.removeEventListener(newMessages);
    telegramClient.removeEventListener(newMessagesIsolated);
    newMessages.exit();
    newMessagesIsolated.exit();

    // -------------------

    await Future.delayed(const Duration(seconds: 5));
    telegramClient.exit();
  }
}

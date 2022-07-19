import 'dart:isolate';
import 'base.dart';

import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/client.dart';
import 'package:telegram_client/port.dart';
// import 'package:telegram_client/login.dart';

// import '../callback/cli.dart';

class TelegramCommandLogin extends TelegramCommand {
  final name = 'login';
  final description = 'Login a Telegram account.';

  void run() async {
    var telegramClient = TelegramClient(
      libtdjsonPath: globalResults!['libtdjson-path'],
    );

    var sub = telegramClient.telegramEvents.listen((event) {
      print('${Isolate.current.debugName} $runtimeType.run $event');
    });
    telegramClient.send(tdFunction: GetAuthorizationState());

    await Future.delayed(const Duration(seconds: 5));
    sub.cancel();
    await Future.delayed(const Duration(seconds: 5));

    // ----------------------------

    // var telegramClient = PortMessenger(
    //     portMessageHandler: TelegramClientMessageHandler(
    //   libtdjsonPath: globalResults!['libtdjson-path'],
    // ));

    // var sub = telegramClient.events.listen((event) {
    //   print('${Isolate.current.debugName} $runtimeType.run $event');
    // });

    // telegramClient.sendPort.send(TdFunctionMessage(
    //   tdFunction: GetAuthorizationState(),
    // ));

    // await Future.delayed(const Duration(seconds: 5));
    // sub.cancel();
    // telegramClient.exit();
    // await Future.delayed(const Duration(seconds: 5));

    // ----------------------------

    // var telegramClient = await PortMessenger.isolate(
    //     portMessageHandler: TelegramClientMessageHandler(
    //   libtdjsonPath: globalResults!['libtdjson-path'],
    // ));

    // var sub = telegramClient.events.listen((event) {
    //   print('${Isolate.current.debugName} $runtimeType.run $event');
    // });

    // telegramClient.sendPort.send(TdFunctionMessage(
    //   tdFunction: GetAuthorizationState(),
    // ));

    // await Future.delayed(const Duration(seconds: 5));
    // sub.cancel();
    // telegramClient.exit();
    // await Future.delayed(const Duration(seconds: 5));

    // ----------------------------

    // var telegramClient = PortMessenger(
    //     portMessageHandler: TelegramClientMessageHandler(
    //   libtdjsonPath: globalResults!['libtdjson-path'],
    // ));

    // await Isolate.spawn((List<dynamic> msg) async {
    //   var sendPort = msg[0];
    //   var events = msg[1];
    //   // var sub = events.listen((event) {
    //   //   print('${Isolate.current.debugName} $runtimeType.run $event');
    //   // });

    //   sendPort.send(TdFunctionMessage(
    //     tdFunction: GetAuthorizationState(),
    //   ));

    //   // sub.cancel();
    // }, [telegramClient.sendPort, telegramClient.events]);

    // await Future.delayed(const Duration(seconds: 5));
    // telegramClient.exit();
    // await Future.delayed(const Duration(seconds: 5));

    // var login = await Login.isolate(
    //   setTdlibParameters: SetTdlibParameters(
    //     parameters: TdlibParameters(
    //       api_id: int.parse(globalResults!['api-id']),
    //       api_hash: globalResults!['api-hash'],
    //       database_directory: globalResults!['database-path'],
    //       use_message_database: false,
    //       device_model: 'Desktop',
    //       application_version: '1.0',
    //       system_language_code: 'en',
    //     ),
    //   ),
    //   checkDatabaseEncryptionKey: CheckDatabaseEncryptionKey(
    //     encryption_key: '',
    //   ),
    //   setAuthenticationPhoneNumber: SetAuthenticationPhoneNumber(
    //     phone_number: globalResults!['phone-number'],
    //   ),
    //   checkAuthenticationCodeWithCallback: CheckAuthenticationCodeWithCallback(
    //     readTelegramCode: readTelegramCode,
    //   ),
    //   authorizationStateWaitOtherDeviceConfirmationWithCallback:
    //       AuthorizationStateWaitOtherDeviceConfirmationWithCallback(
    //     writeQrCodeLink: writeQrCodeLink,
    //   ),
    //   registerUserWithCallback: RegisterUserWithCallback(
    //     readUserFirstName: readUserFirstName,
    //     readUserLastName: readUserLastName,
    //   ),
    //   checkAuthenticationPasswordWithCallback:
    //       CheckAuthenticationPasswordWithCallback(
    //           readUserPassword: readUserPassword),
    // );
    // login.auth(telegramClientSendPort: telegramClient.sendPort);

    // await Future.delayed(const Duration(seconds: 20));
    // login.exit();
    // telegramClient.exit();
  }
}

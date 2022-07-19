// import 'dart:async';
// import 'dart:isolate';

// import 'package:telegram_client/client.dart';
// import 'package:td_json_client/td_json_client.dart';

// class Login {
//   final SetTdlibParameters setTdlibParameters;
//   final CheckDatabaseEncryptionKey checkDatabaseEncryptionKey;
//   final SetAuthenticationPhoneNumber setAuthenticationPhoneNumber;
//   final CheckAuthenticationCodeWithCallback checkAuthenticationCodeWithCallback;
//   final AuthorizationStateWaitOtherDeviceConfirmationWithCallback
//       authorizationStateWaitOtherDeviceConfirmationWithCallback;
//   final RegisterUserWithCallback registerUserWithCallback;
//   final CheckAuthenticationPasswordWithCallback
//       checkAuthenticationPasswordWithCallback;

//   Login({
//     required this.setTdlibParameters,
//     required this.checkDatabaseEncryptionKey,
//     required this.setAuthenticationPhoneNumber,
//     required this.checkAuthenticationCodeWithCallback,
//     required this.authorizationStateWaitOtherDeviceConfirmationWithCallback,
//     required this.registerUserWithCallback,
//     required this.checkAuthenticationPasswordWithCallback,
//   }) {}

//   bool _isAuthorized = false;
//   bool get isAuthorized => _isAuthorized;

//   bool _isClosed = false;
//   bool get isclosed => _isClosed;

//   void _onUpdateAuthorizationState({
//     required SendPort telegramClientSendPort,
//     required Stream<dynamic> telegramClientEvents,
//     required UpdateAuthorizationState updateAuthorizationState,
//   }) {
//     switch (updateAuthorizationState.authorization_state.runtimeType) {
//       case AuthorizationStateWaitTdlibParameters:
//         telegramClientSendPort.send(setTdlibParameters);
//         break;

//       case AuthorizationStateWaitEncryptionKey:
//         telegramClientSendPort.send(checkDatabaseEncryptionKey);
//         break;

//       case AuthorizationStateWaitPhoneNumber:
//         telegramClientSendPort.send(setAuthenticationPhoneNumber);
//         break;

//       case AuthorizationStateWaitCode:
//         telegramClientSendPort.send(CheckAuthenticationCode(
//             code: checkAuthenticationCodeWithCallback.readTelegramCode()));
//         break;

//       case AuthorizationStateWaitOtherDeviceConfirmation:
//         var authorizationStateWaitOtherDeviceConfirmation =
//             updateAuthorizationState
//                 as AuthorizationStateWaitOtherDeviceConfirmation;
//         authorizationStateWaitOtherDeviceConfirmationWithCallback
//             .writeQrCodeLink(
//                 authorizationStateWaitOtherDeviceConfirmation.link);
//         break;

//       case AuthorizationStateWaitRegistration:
//         telegramClientSendPort.send(RegisterUser(
//             first_name: registerUserWithCallback.readUserFirstName(),
//             last_name: registerUserWithCallback.readUserLastName()));
//         break;

//       case AuthorizationStateWaitPassword:
//         telegramClientSendPort.send(CheckAuthenticationPassword(
//             password:
//                 checkAuthenticationPasswordWithCallback.readUserPassword()));
//         break;

//       case AuthorizationStateReady:
//         _isAuthorized = true;
//         _unsubscribe(telegramClientSendPort);
//         break;
//       case AuthorizationStateLoggingOut:
//         _isClosed = true;
//         _unsubscribe(telegramClientSendPort);
//         break;
//       case AuthorizationStateClosing:
//         _isClosed = true;
//         _unsubscribe(telegramClientSendPort);
//         break;
//       case AuthorizationStateClosed:
//         _isClosed = true;
//         _unsubscribe(telegramClientSendPort);
//         break;
//     }
//   }

//   void _onError({
//     required SendPort telegramClientSendPort,
//     required Error error,
//   }) {}

//   late final ReceivePort telegramClientReceivePort;

//   late final StreamSubscription _authSubscription;
//   late final StreamSubscription _errorSuscription;

//   void auth({
//     required SendPort telegramClientSendPort,
//   }) {
//     telegramClientReceivePort = ReceivePort();
//     telegramClientReceivePort.sendPort;
//     var telegramClientEvents = telegramClientReceivePort.asBroadcastStream();

//     telegramClientSendPort.send(TelegramClientSubscribeEvents(
//       sendPort: telegramClientReceivePort.sendPort,
//     ));

//     _authSubscription = telegramClientEvents
//         .where((event) => event is UpdateAuthorizationState)
//         .listen((message) {
//       print('${Isolate.current.debugName} received $runtimeType $message');
//       _onUpdateAuthorizationState(
//         telegramClientSendPort: telegramClientSendPort,
//         telegramClientEvents: telegramClientEvents,
//         updateAuthorizationState: message,
//       );
//     });
//     _errorSuscription =
//         telegramClientEvents.where((event) => event is Error).listen((message) {
//       print('${Isolate.current.debugName} received $runtimeType $message');
//       _onError(
//         telegramClientSendPort: telegramClientSendPort,
//         error: message,
//       );
//     });
//     telegramClientSendPort.send(GetAuthorizationState());
//   }

//   void _unsubscribe(
//     SendPort telegramClientSendPort,
//   ) {
//     telegramClientSendPort.send(TelegramClientUnsubscribeEvents(
//       sendPort: telegramClientReceivePort.sendPort,
//     ));
//     _authSubscription.cancel();
//     _errorSuscription.cancel();
//   }

//   static Future<LoginIsolated> isolate({
//     required setTdlibParameters,
//     required checkDatabaseEncryptionKey,
//     required setAuthenticationPhoneNumber,
//     required checkAuthenticationCodeWithCallback,
//     required authorizationStateWaitOtherDeviceConfirmationWithCallback,
//     required registerUserWithCallback,
//     required checkAuthenticationPasswordWithCallback,
//   }) async {
//     var loginIsolated = LoginIsolated(
//       setTdlibParameters: setTdlibParameters,
//       checkDatabaseEncryptionKey: checkDatabaseEncryptionKey,
//       setAuthenticationPhoneNumber: setAuthenticationPhoneNumber,
//       checkAuthenticationCodeWithCallback: checkAuthenticationCodeWithCallback,
//       authorizationStateWaitOtherDeviceConfirmationWithCallback:
//           authorizationStateWaitOtherDeviceConfirmationWithCallback,
//       registerUserWithCallback: registerUserWithCallback,
//       checkAuthenticationPasswordWithCallback:
//           checkAuthenticationPasswordWithCallback,
//     );

//     await loginIsolated.spawn();
//     return loginIsolated;
//   }

//   void exit() {}
// }

// class LoginIsolated extends Login {
//   LoginIsolated({
//     required super.setTdlibParameters,
//     required super.checkDatabaseEncryptionKey,
//     required super.setAuthenticationPhoneNumber,
//     required super.checkAuthenticationCodeWithCallback,
//     required super.authorizationStateWaitOtherDeviceConfirmationWithCallback,
//     required super.registerUserWithCallback,
//     required super.checkAuthenticationPasswordWithCallback,
//   }) {}

//   late final ReceivePort _receivePort;
//   late final SendPort _sendPort;
//   late final Stream<dynamic> _receivePortBroadcast;

//   Future<void> spawn() async {
//     _receivePort = ReceivePort();
//     _receivePortBroadcast = _receivePort.asBroadcastStream();

//     var isolated = Login(
//       setTdlibParameters: setTdlibParameters,
//       checkDatabaseEncryptionKey: checkDatabaseEncryptionKey,
//       setAuthenticationPhoneNumber: setAuthenticationPhoneNumber,
//       checkAuthenticationCodeWithCallback: checkAuthenticationCodeWithCallback,
//       authorizationStateWaitOtherDeviceConfirmationWithCallback:
//           authorizationStateWaitOtherDeviceConfirmationWithCallback,
//       registerUserWithCallback: registerUserWithCallback,
//       checkAuthenticationPasswordWithCallback:
//           checkAuthenticationPasswordWithCallback,
//     );

//     await Isolate.spawn(
//       LoginIsolated.entryPoint,
//       [isolated, _receivePort.sendPort],
//       debugName: runtimeType.toString(),
//     );

//     _sendPort = await _receivePortBroadcast.first as SendPort;
//   }

//   static Future<void> entryPoint(List<dynamic> spawnMessage) async {
//     Login isolated = spawnMessage[0];
//     SendPort sendPort = spawnMessage[1];

//     var receivePort = ReceivePort();
//     sendPort.send(receivePort.sendPort);

//     receivePort.listen((message) {
//       if (message is LoginAuthMessage) {
//         isolated.auth(
//           telegramClientSendPort: message.telegramClientSendPort,
//         );
//       }
//     });
//   }

//   @override
//   void auth({
//     required SendPort telegramClientSendPort,
//   }) {
//     _sendPort.send(LoginAuthMessage(
//       telegramClientSendPort: telegramClientSendPort,
//     ));
//   }

//   @override
//   void exit() {
//     _receivePort.close();
//   }
// }

// class LoginAuthMessage {
//   final SendPort telegramClientSendPort;
//   LoginAuthMessage({
//     required this.telegramClientSendPort,
//   });
// }

// class CheckAuthenticationCodeWithCallback extends CheckAuthenticationCode {
//   final String Function() readTelegramCode;
//   CheckAuthenticationCodeWithCallback({
//     required this.readTelegramCode,
//   });
// }

// class AuthorizationStateWaitOtherDeviceConfirmationWithCallback
//     extends AuthorizationStateWaitOtherDeviceConfirmation {
//   final void Function(String? link) writeQrCodeLink;
//   AuthorizationStateWaitOtherDeviceConfirmationWithCallback({
//     required this.writeQrCodeLink,
//   });
// }

// class RegisterUserWithCallback extends RegisterUser {
//   final String Function() readUserFirstName;
//   final String Function() readUserLastName;
//   RegisterUserWithCallback({
//     required this.readUserFirstName,
//     required this.readUserLastName,
//   });
// }

// class CheckAuthenticationPasswordWithCallback
//     extends CheckAuthenticationPassword {
//   final String Function() readUserPassword;
//   CheckAuthenticationPasswordWithCallback({
//     required this.readUserPassword,
//   });
// }

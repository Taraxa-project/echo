// import 'dart:async';

// import 'package:td_json_client/td_json_client.dart';

// import 'isolateable.dart';

// class NewMessages extends Isolateable {
//   @override
//   Stream<dynamic> get events => _streamController.stream;

//   late StreamController<dynamic> _streamController;

//   NewMessages() {
//     _streamController = StreamController.broadcast();
//   }

//   StreamSubscription? _telegramClientSubscription;

//   void listen({required Isolateable telegramClient}) {
//     _telegramClientSubscription = telegramClient.events
//         .where((event) => event is UpdateNewMessage)
//         .listen((message) {
//       print('$runtimeType $message');
//       _streamController.add(message);
//     });
//   }

//   @override
//   void exit() {
//     _telegramClientSubscription?.cancel();
//   }
// }

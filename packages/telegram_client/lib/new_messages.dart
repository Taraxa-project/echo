import 'package:td_json_client/td_json_client.dart';

import 'isolated.dart';

class NewMessages extends IsolatedSubscriber {
  static Future<NewMessages> create() async {
    final newMessages = NewMessages._create();
    await newMessages.spawn();
    return newMessages;
  }

  NewMessages._create() {}

  @override
  void onSubscribedMessage(SubscribedMessage isolateMessage) {
    publisherReceivePortBroadcast
        ?.where((message) =>
            message is TdObjectMessage && message.td is UpdateNewMessage)
        .listen((event) {
      onUpdateNewMessage(event.td);
    });

    publisherReceivePortBroadcast
        ?.where((message) => message is TdObjectMessage && message.td is Error)
        .listen((event) {
      onError(event.td);
    });
  }

  void onUpdateNewMessage(UpdateNewMessage updateNewMessage) {
    print(updateNewMessage);
  }

  void onError(Error error) {
    print(error);
  }
}

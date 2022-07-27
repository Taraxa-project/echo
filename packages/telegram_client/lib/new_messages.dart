import 'dart:async';
import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

import 'port.dart';

class NewMessages with WithPorts {
  StreamSubscription? _updateNewMessage;
  StreamSubscription? _errorSubscription;

  void readNewMessages() {
    _updateNewMessage = subscribedEvents
        ?.where((message) => message is UpdateNewMessage)
        .listen((event) {
      _onUpdateNewMessage(event);
    });

    _errorSubscription =
        subscribedEvents?.where((message) => message is Error).listen((event) {
      _onError(event);
    });
  }

  void _onUpdateNewMessage(UpdateNewMessage updateNewMessage) {
    var content = updateNewMessage.message?.content;
    if (content is MessageText && content.text is FormattedText) {
      print(
          '[${Isolate.current.debugName}._onUpdateNewMessage] ${content.text?.text}');
    }
  }

  void _onError(Error error) {
    print(error);
  }

  @override
  void handlePortMessage(dynamic portMessage) {
    if (portMessage is ReadNewMessages) {
      readNewMessages();
    }
  }

  Future<void> _cancelStreamSubscriptions() async {
    await _updateNewMessage?.cancel();
    await _errorSubscription?.cancel();
  }

  Future<void> exit() async {
    await _cancelStreamSubscriptions();
    closePorts();
  }
}

class ReadNewMessages {}

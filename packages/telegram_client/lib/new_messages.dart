import 'dart:async';
import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

import 'client.dart';
import 'port.dart';

class NewMessages with WithPorts {
  ReceivePort? _telegramClientReceivePort;

  StreamSubscription? _updateNewMessage;
  StreamSubscription? _errorSubscription;

  void readNewMessages({
    required SendPort? telegramClientSendPort,
  }) {
    _telegramClientReceivePort = ReceivePort();

    telegramClientSendPort?.send(SubscribeTelegramEvents(
      sendPort: _telegramClientReceivePort!.sendPort,
    ));

    var telegramClientEvents = _telegramClientReceivePort!.asBroadcastStream();

    _updateNewMessage = telegramClientEvents
        .where((message) => message is UpdateNewMessage)
        .listen((event) {
      _onUpdateNewMessage(event);
    });

    _errorSubscription = telegramClientEvents
        .where((message) => message is Error)
        .listen((event) {
      _onError(event);
    });
  }

  void _onUpdateNewMessage(UpdateNewMessage updateNewMessage) {
    var content = updateNewMessage.message?.content;
    if (content is MessageText && content.text is FormattedText) {
      print(
          '${Isolate.current.debugName} Received new message ${content.text?.text}');
    }
  }

  void _onError(Error error) {
    print(error);
  }

  @override
  void handlePortMessage(dynamic portMessage) {
    if (portMessage is ReadNewMessages) {
      readNewMessages(
        telegramClientSendPort: portMessage.telegramClientSendPort,
      );
    }
  }

  Future<void> _cancelStreamSubscriptions() async {
    await _updateNewMessage?.cancel();
    await _errorSubscription?.cancel();
  }

  Future<void> exit() async {
    closePorts();
    await _cancelStreamSubscriptions();
    _telegramClientReceivePort?.close();
  }
}

class ReadNewMessages {
  final SendPort? telegramClientSendPort;
  ReadNewMessages({
    this.telegramClientSendPort,
  });
}

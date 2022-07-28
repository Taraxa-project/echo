import 'dart:isolate';

import 'package:uuid/uuid.dart';
import 'package:td_json_client/td_json_client.dart';

import 'base.dart';

class NewMesssages extends TelegramEventListener {
  NewMesssages() {
    uniqueKey = Uuid().v1();
  }

  @override
  void update(event) {
    if (event is UpdateNewMessage) {
      _onUpdateNewMessage(event);
    } else if (event is Error) {
      _onError(event);
    }
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

  void exit() {}

  static Future<NewMesssagesIsolated> isolate() async {
    NewMesssagesIsolated newMesssagesIsolated = NewMesssagesIsolated();
    await newMesssagesIsolated.spawn();
    return newMesssagesIsolated;
  }
}

class NewMesssagesIsolated extends NewMesssages {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  SendPort? _isolateSendPort;

  NewMesssagesIsolated() {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
    uniqueKey = Uuid().v1();
  }

  @override
  void update(event) {
    _isolateSendPort?.send(UpdateEvent(event));
  }

  Future<void> spawn() async {
    await Isolate.spawn(
      NewMesssagesIsolated._entryPoint,
      [NewMesssages(), _isolateReceivePort.sendPort],
      debugName: runtimeType.toString(),
    );

    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(List<dynamic> initialSpawnMessage) {
    NewMesssages newMesssages = initialSpawnMessage[0];
    SendPort parentSendPort = initialSpawnMessage[1];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is UpdateEvent) {
        newMesssages.update(message.event);
      }
    });
  }

  @override
  void exit() {
    _isolateReceivePort.close();
  }
}

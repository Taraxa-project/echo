import 'dart:isolate';
import 'dart:async';

import 'package:td_json_client/td_json_client.dart';

import 'port.dart';

class TelegramClient with WithPorts {
  final String libtdjsonPath;

  late final StreamController _tdStreamController;
  Stream<dynamic> get telegramEvents => _tdStreamController.stream;

  TelegramClient({
    required this.libtdjsonPath,
  }) {
    _tdStreamController = StreamController.broadcast(
      onListen: _tdStart,
      onCancel: _tdStop,
    );
  }

  bool _isInitialized = false;
  late final TdJsonClient _tdJsonClient;
  late final int _tdJsonClientId;
  void init() {
    if (!_isInitialized) {
      _tdJsonClient = TdJsonClient(libtdjsonPath: libtdjsonPath);
      _tdJsonClientId = _tdJsonClient.create_client_id();
      _isInitialized = true;
    }
  }

  void send({
    required TdFunction tdFunction,
  }) {
    init();

    _tdJsonClient.send(_tdJsonClientId, tdFunction);
    print('${Isolate.current.debugName} $runtimeType.send $tdFunction');
  }

  Duration readEventsFrequency = Duration(milliseconds: 10);
  Timer? timer;
  void _tdStart() {
    init();

    print('${Isolate.current.debugName} $runtimeType._tdStart');
    timer = Timer.periodic(readEventsFrequency, _tdReceive);
  }

  void _tdStop() {
    init();

    print('${Isolate.current.debugName} $runtimeType._tdStop');
    timer?.cancel();
    timer = null;
  }

  double waitTimeout = 0.005;
  bool _isTdReceiving = false;
  void _tdReceive(Timer timer) {
    init();

    if (!_isTdReceiving) {
      _isTdReceiving = true;

      var event = _tdJsonClient.receive(waitTimeout: waitTimeout);
      if (event != null) {
        _tdStreamController.add(event);
      }

      _isTdReceiving = false;
    }
  }

  Map<String?, StreamSubscription> _subscribers = {};

  @override
  void handlePortMessage(dynamic portMessage) {
    if (portMessage is TdFunction) {
      send(tdFunction: portMessage);
    } else if (portMessage is SubscribeEvents) {
      print('subscribed');
      _subscribers[portMessage.uniqueKey] = telegramEvents.listen((event) {
        portMessage.sendPort?.send(event);
      });
    } else if (portMessage is UnsubscribeEvents) {
      print('unsubscribed');
      _subscribers.remove(portMessage.uniqueKey)?.cancel();
    }
  }
}

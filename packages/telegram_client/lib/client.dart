import 'dart:async';
import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

import 'base.dart';

class TelegramClient extends TelegramEventGenerator implements TelegramSend {
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
        // print('${Isolate.current.debugName} $runtimeType._tdReceive $event');
        _tdStreamController.add(event);
      }

      _isTdReceiving = false;
    }
  }

  @override
  void send(
    TdFunction tdFunction,
  ) {
    init();

    _tdJsonClient.send(_tdJsonClientId, tdFunction);
    print('${Isolate.current.debugName} $runtimeType.send $tdFunction');
  }

  Map<String, StreamSubscription> _eventListeners = {};

  @override
  void addeventListener(TelegramEventListener telegramEventListener) {
    _eventListeners[telegramEventListener.uniqueKey] =
        telegramEvents.listen((event) {
      telegramEventListener.update(event);
    });
  }

  @override
  void removeEventListener(TelegramEventListener telegramEventListener) {
    var listener = _eventListeners.remove(telegramEventListener.uniqueKey);
    listener?.cancel();
  }

  static Future<TelegramClientIsolated> isolate({
    required libtdjsonPath,
  }) async {
    TelegramClientIsolated telegramClientIsolated =
        TelegramClientIsolated(libtdjsonPath: libtdjsonPath);
    await telegramClientIsolated.spawn();
    return telegramClientIsolated;
  }
}

class TelegramClientIsolated extends TelegramClient {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  SendPort? _isolateSendPort;

  TelegramClientIsolated({
    required super.libtdjsonPath,
  }) {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
  }

  @override
  void send(
    TdFunction tdFunction,
  ) {
    _isolateSendPort?.send(tdFunction);
  }

  @override
  void addeventListener(TelegramEventListener telegramEventListener) {
    _eventListeners[telegramEventListener.uniqueKey] =
        _isolateReceivePortBroadcast.listen((event) {
      telegramEventListener.update(event);
    });

    _isolateSendPort?.send(AddEventListener(SendPortEventListener(
      telegramEventListener.uniqueKey,
      _isolateReceivePort.sendPort,
    )));
  }

  @override
  void removeEventListener(TelegramEventListener telegramEventListener) {
    _isolateSendPort?.send(RemoveEventListener(SendPortEventListener(
      telegramEventListener.uniqueKey,
      _isolateReceivePort.sendPort,
    )));

    super.removeEventListener(telegramEventListener);
  }

  Future<void> spawn() async {
    await Isolate.spawn(
      TelegramClientIsolated._entryPoint,
      [
        TelegramClient(libtdjsonPath: libtdjsonPath),
        _isolateReceivePort.sendPort
      ],
      debugName: runtimeType.toString(),
    );
    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(List<dynamic> initialSpawnMessage) {
    TelegramClient telegramClient = initialSpawnMessage[0];
    SendPort parentSendPort = initialSpawnMessage[1];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is TdFunction) {
        telegramClient.send(message);
      } else if (message is AddEventListener) {
        telegramClient.addeventListener(message.eventListener);
      } else if (message is RemoveEventListener) {
        telegramClient.removeEventListener(message.eventListener);
      }
    });
  }

  void exit() {
    _isolateReceivePort.close();
  }
}

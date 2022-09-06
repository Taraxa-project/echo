import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';

import 'package:td_json_client/td_json_client.dart';

import 'base.dart';

class TelegramClient extends TelegramEventGenerator implements TelegramSender {
  final String libtdjsonlcPath;

  late final StreamController _tdStreamController;
  Stream<dynamic> get telegramEvents => _tdStreamController.stream;

  TelegramClient({
    required this.libtdjsonlcPath,
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
      _tdJsonClient = TdJsonClient(libtdjsonlcPath: libtdjsonlcPath);
      _tdJsonClientId = _tdJsonClient.create_client_id();
      _isInitialized = true;
    }
  }

  Duration readEventsFrequency = Duration(milliseconds: 10);
  Timer? timer;
  void _tdStart() {
    init();

    timer = Timer.periodic(readEventsFrequency, _tdReceive);
  }

  void _tdStop() {
    init();

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

  @override
  void send(
    TdFunction tdFunction,
  ) {
    init();

    _tdJsonClient.send(_tdJsonClientId, tdFunction);
  }

  Map<String, StreamSubscription> _eventListeners = {};

  @override
  void addEventListener(
    TelegramEventListener telegramEventListener, {
    bool Function(dynamic event) filter = TelegramEventGenerator.allEvents,
  }) {
    _eventListeners[telegramEventListener.uniqueKey] =
        telegramEvents.where((ev) => filter(ev)).listen((event) {
      telegramEventListener.onEvent(event);
    });
  }

  @override
  void removeEventListener(TelegramEventListener telegramEventListener) {
    var listener = _eventListeners.remove(telegramEventListener.uniqueKey);
    listener?.cancel();
  }

  static Future<TelegramClientIsolated> isolate({
    required libtdjsonlcPath,
  }) async {
    TelegramClientIsolated telegramClientIsolated =
        TelegramClientIsolated(libtdjsonlcPath: libtdjsonlcPath);
    await telegramClientIsolated.spawn();
    return telegramClientIsolated;
  }
}

class TelegramClientIsolated extends TelegramClient {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  SendPort? _isolateSendPort;

  late final SendPortEventListener _sendPortEventListener;
  TelegramClientIsolated({
    required super.libtdjsonlcPath,
  }) {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
    _sendPortEventListener =
        SendPortEventListener(sendPort: _isolateReceivePort.sendPort);
  }

  @override
  void send(
    TdFunction tdFunction,
  ) {
    _isolateSendPort?.send(tdFunction);
  }

  @override
  void addEventListener(
    TelegramEventListener telegramEventListener, {
    bool Function(dynamic event) filter = TelegramEventGenerator.allEvents,
  }) {
    _eventListeners[telegramEventListener.uniqueKey] =
        _isolateReceivePortBroadcast.where((ev) => filter(ev)).listen((event) {
      telegramEventListener.onEvent(event);
    });
    if (_eventListeners.keys.length == 1) {
      _isolateSendPort?.send(AddEventListener(_sendPortEventListener));
    }
  }

  @override
  void removeEventListener(TelegramEventListener telegramEventListener) {
    if (_eventListeners.keys.length == 1) {
      _isolateSendPort?.send(RemoveEventListener(_sendPortEventListener));
    }
    super.removeEventListener(telegramEventListener);
  }

  Future<void> spawn() async {
    await Isolate.spawn(
      TelegramClientIsolated._entryPoint,
      [
        TelegramClient(libtdjsonlcPath: libtdjsonlcPath),
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
        telegramClient.addEventListener(message.eventListener);
      } else if (message is RemoveEventListener) {
        telegramClient.removeEventListener(message.eventListener);
      }
    });
  }

  void exit() {
    _isolateReceivePort.close();
  }

  /// The TelegramClient [Logger].
  Logger? _logger;

  void setupLogs(
    Logger? logger,
    Logger? loggerTdLib,
  ) {
    _logger = logger;
    _tdJsonClient.setupLogs(logger, loggerTdLib);
  }
}

import 'dart:async';

import 'package:td_json_client/td_json_client.dart';

import 'isolated.dart';

class TelegramClient extends IsolatedPublisher {
  final String libtdjsonPath;
  late final TdJsonClient _tdJsonClient;
  late final int _tdJsonClientId;

  static Future<TelegramClient> create({
    required String libtdjsonPath,
  }) async {
    final TelegramClient telegramClient = TelegramClient._create(
      libtdjsonPath: libtdjsonPath,
    );
    await telegramClient.spawn();
    return telegramClient;
  }

  TelegramClient._create({
    required String this.libtdjsonPath,
  });

  @override
  void init() {
    _tdJsonClient = TdJsonClient(libtdjsonPath: libtdjsonPath);
    _tdJsonClientId = _tdJsonClient.create_client_id();

    _receive().listen((event) {
      _onTdJsonClientMessage(event as TdObject);
    });

    isolateReceivePortBroadcast
        .where((event) => event is TdFunctionMessage)
        .listen((message) {
      _onTdFunction(message.td);
    });
  }

  void _onTdFunction(TdFunction tdFunction) {
    _tdJsonClient.send(_tdJsonClientId, tdFunction);
  }

  void _onTdJsonClientMessage(TdObject td) {
    final tdObjectMessage = TdObjectMessage(td: td);

    // TODO do or do not send to parent?!
    isolateSendPort.send(tdObjectMessage);

    subscribersSendPorts.forEach((sendPort) {
      sendPort.send(tdObjectMessage);
    });
  }

  bool _isReceiving = false;

  Stream<Td> _receive({double waitTimeout = 0.005}) {
    var streamController = StreamController<Td>();

    Timer.periodic(Duration(microseconds: 10), (timer) {
      if (!_isReceiving) {
        _isReceiving = true;

        var event = _tdJsonClient.receive(waitTimeout: waitTimeout);
        if (event != null) streamController.add(event);

        _isReceiving = false;
      }
    });

    return streamController.stream;
  }
}

import 'dart:async';
import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

import 'port.dart';
import 'client.dart';

class GetChatList with WithPorts {
  ReceivePort? _telegramClientReceivePort;

  StreamSubscription? _updateInfoSubscription;
  StreamSubscription? _errorSubscription;

  void listChats({
    required SendPort? telegramClientSendPort,
    required int limit,
  }) {
    _telegramClientReceivePort = ReceivePort();

    telegramClientSendPort?.send(SubscribeTelegramEvents(
      sendPort: _telegramClientReceivePort!.sendPort,
    ));

    var telegramClientEvents = _telegramClientReceivePort!.asBroadcastStream();

    _updateInfoSubscription = telegramClientEvents
        .where((message) =>
            message is UpdateSupergroupFullInfo ||
            message is UpdateBasicGroupFullInfo ||
            message is UpdateUserFullInfo)
        .listen((event) {
      _onUpdateInfo(event);
    });

    _errorSubscription = telegramClientEvents
        .where((message) => message is Error)
        .listen((event) {
      _onError(event);
    });

    telegramClientSendPort?.send(
      GetChats(limit: limit),
    );
  }

  void _onUpdateInfo(TdObject tdObject) {
    // if (tdObject is UpdateSupergroupFullInfo) {
    //   print(tdObject.supergroup_full_info?.description);
    // } else if (tdObject is UpdateBasicGroupFullInfo) {
    //   print(tdObject.basic_group_full_info?.description);
    // } else if (tdObject is UpdateUserFullInfo) {
    //   print(tdObject.user_full_info?.description);
    // }
    print(tdObject);
  }

  void _onError(Error error) {
    print(error);
  }

  @override
  void handlePortMessage(dynamic portMessage) {
    if (portMessage is ListChats) {
      listChats(
        telegramClientSendPort: portMessage.telegramClientSendPort,
        limit: portMessage.limit,
      );
    }
  }

  Future<void> _cancelStreamSubscriptions() async {
    await _updateInfoSubscription?.cancel();
    await _errorSubscription?.cancel();
  }

  Future<void> exit() async {
    closePorts();
    await _cancelStreamSubscriptions();
    _telegramClientReceivePort?.close();
  }
}

class ListChats {
  final SendPort? telegramClientSendPort;
  int limit;
  ListChats({
    this.telegramClientSendPort,
    required this.limit,
  });
}

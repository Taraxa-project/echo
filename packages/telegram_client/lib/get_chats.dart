import 'dart:async';

import 'package:td_json_client/td_json_client.dart';

import 'port.dart';

class GetChatList with WithPorts {
  StreamSubscription? _updateInfoSubscription;
  StreamSubscription? _errorSubscription;

  void listChats({
    required int limit,
  }) {
    _updateInfoSubscription = subscribedEvents
        ?.where((message) =>
            message is UpdateSupergroupFullInfo ||
            message is UpdateBasicGroupFullInfo ||
            message is UpdateUserFullInfo)
        .listen((event) {
      _onUpdateInfo(event);
    });

    _errorSubscription =
        subscribedEvents?.where((message) => message is Error).listen((event) {
      _onError(event);
    });

    subscribedSendPort?.send(
      GetChats(limit: limit),
    );
  }

  void _onUpdateInfo(TdObject tdObject) {
    print(tdObject);
  }

  void _onError(Error error) {
    print(error);
  }

  @override
  void handlePortMessage(dynamic portMessage) {
    if (portMessage is ListChats) {
      listChats(limit: portMessage.limit);
    }
  }

  Future<void> _cancelStreamSubscriptions() async {
    await _updateInfoSubscription?.cancel();
    await _errorSubscription?.cancel();
  }

  Future<void> exit() async {
    await _cancelStreamSubscriptions();
    closePorts();
  }
}

class ListChats {
  int limit;
  ListChats({
    required this.limit,
  });
}

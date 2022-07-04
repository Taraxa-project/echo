import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

abstract class Isolated {
  late final ReceivePort receivePort;
  late final SendPort sendPort;
  late final Stream<dynamic> receivePortBroadcast;

  late final SendPort isolateSendPort;
  late final ReceivePort isolateReceivePort;
  late final Stream<dynamic> isolateReceivePortBroadcast;

  Future<void> spawn() async {
    // Creates a port to receive message from the child isolate
    var _receivePort = ReceivePort();

    // Creates a broadcast stream
    var _receivePortBroadcast = _receivePort.asBroadcastStream();

    // Add [SendPort] to the isolate
    // Spawns isolate
    isolateSendPort = _receivePort.sendPort;
    await Isolate.spawn(
        Isolated._entryPoint,
        InitialSpawnMessage(
          isolated: this,
        ));

    // We can now assign the receive ports to this
    // Use [receivePort] for multiple stream subscriptions
    receivePort = _receivePort;
    receivePortBroadcast = _receivePortBroadcast;

    // The first message is always a [SendPort]
    // Use this to send messages to the child isolate
    sendPort = await receivePortBroadcast.first as SendPort;
  }

  static Future<void> _entryPoint(InitialSpawnMessage spawnableMessage) async {
    // Just unwrap the value from [InitialSpawnMessage]
    var isolated = spawnableMessage.isolated;

    // Creates and sends a port back to the parent isolate
    // Use this to receive messages from parent isolate
    isolated.isolateReceivePort = ReceivePort();
    isolated.isolateReceivePortBroadcast =
        isolated.isolateReceivePort.asBroadcastStream();
    isolated.isolateSendPort.send(isolated.isolateReceivePort.sendPort);

    // Publisher receives subscription request
    isolated.isolateReceivePortBroadcast
        .where((event) => event is SubscribeMessage)
        .listen(
      (message) {
        isolated.onSubscribeMessage(message);
      },
    );

    // Starts a subscription request
    isolated.isolateReceivePortBroadcast
        .where((event) => event is SubscribeToMessage)
        .listen(
      (message) {
        isolated.onSubscribeToMessage(message);
      },
    );

    // Subscribed successfully
    isolated.isolateReceivePortBroadcast
        .where((event) => event is SubscribedMessage)
        .listen(
      (message) {
        isolated.onSubscribedMessage(message);
      },
    );

    // Listen for messages from the parent isolate
    isolated.isolateReceivePortBroadcast.listen(
      (message) {
        isolated.onIsolateMessage(message);
      },
    );

    // Run your init
    isolated.init();
  }

  // Override this if you need initialization code
  void init() {}

  // Override this if you need to handle every message
  void onIsolateMessage(IsolateMessage isolateMessage) {}

  void onSubscribeToMessage(SubscribeToMessage isolateMessage);
  void onSubscribeMessage(SubscribeMessage isolateMessage);
  void onSubscribedMessage(SubscribedMessage isolateMessage);
}

abstract class IsolatedPublisher extends Isolated {
  List<SendPort> subscribersSendPorts = [];

  @override
  void onSubscribeMessage(SubscribeMessage isolateMessage) {
    subscribersSendPorts.add(isolateMessage.subscriberSendPort);
    isolateMessage.subscriberSendPort.send(SubscribedMessage());
  }

  @override
  void onSubscribeToMessage(SubscribeToMessage isolateMessage) {}

  @override
  void onSubscribedMessage(SubscribedMessage isolateMessage) {}
}

abstract class IsolatedSubscriber extends Isolated {
  late final SendPort publisherSendPort;
  late final ReceivePort publisherReceivePort;
  late final Stream<dynamic>? publisherReceivePortBroadcast;

  void subscribe({
    required IsolatedPublisher isolatedPublisher,
  }) {
    sendPort.send(SubscribeToMessage(
      publisherSendPort: isolatedPublisher.sendPort,
    ));
  }

  @override
  void onSubscribeMessage(SubscribeMessage isolateMessage) {}

  @override
  void onSubscribeToMessage(SubscribeToMessage isolateMessage) {
    publisherSendPort = isolateMessage.publisherSendPort;

    var publisherReceivePort = ReceivePort();

    publisherReceivePortBroadcast = publisherReceivePort.asBroadcastStream();
    publisherReceivePortBroadcast?.listen((message) {
      onIsolateMessage(message);
    });
    publisherReceivePortBroadcast
        ?.where((message) => message is SubscribedMessage)
        .listen((event) {
      onSubscribedMessage(event);
    });

    publisherSendPort.send(SubscribeMessage(
      subscriberSendPort: publisherReceivePort.sendPort,
    ));
  }

  @override
  void onSubscribedMessage(SubscribedMessage isolateMessage) {}
}

abstract class IsolateMessage {}

class InitialSpawnMessage extends IsolateMessage {
  Isolated isolated;

  InitialSpawnMessage({
    required this.isolated,
  });
}

abstract class TdMesssage extends IsolateMessage {
  final Td td;
  TdMesssage({
    required this.td,
  });
}

class TdObjectMessage extends TdMesssage {
  TdObjectMessage({
    required TdObject super.td,
  });
}

class TdFunctionMessage extends TdMesssage {
  TdFunctionMessage({
    required TdFunction super.td,
  });
}

abstract class SubscriptionMessage extends IsolateMessage {}

class SubscribeToMessage extends SubscriptionMessage {
  SendPort publisherSendPort;
  SubscribeToMessage({
    required this.publisherSendPort,
  });
}

class SubscribeMessage extends SubscriptionMessage {
  SendPort subscriberSendPort;
  SubscribeMessage({
    required this.subscriberSendPort,
  });
}

class SubscribedMessage extends SubscriptionMessage {}

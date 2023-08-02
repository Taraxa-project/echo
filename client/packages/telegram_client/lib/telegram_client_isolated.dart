import 'dart:async';
import 'dart:isolate';

import 'package:td_json_client/td_api.dart';
import 'package:uuid/uuid.dart';
import 'package:logging/logging.dart';

import 'telegram_client_interface.dart';
import 'telegram_client.dart';
import 'log_isolated.dart';
import 'db_isolated.dart';
import 'ingester_contract.dart';
import 'isolate.dart';

class TelegramClientIsolated implements TelegramClientInterface {
  final IsolatedProxy isolatedProxy;

  TelegramClientIsolated._(
    this.isolatedProxy,
  );

  static Future<TelegramClientIsolated> spawn(
    LogIsolated log,
    String libtdjsonlcPath,
    Level logLevelLibTdJson,
    Uri? proxyUri, [
    String? debugName,
  ]) async {
    final init = Init(log, libtdjsonlcPath, logLevelLibTdJson, proxyUri);
    final sendPort = await Isolater.spawn(
        TelegramClientIsolated._entryPoint, init, debugName);
    final isolatedProxy = IsolatedProxy(sendPort);
    return TelegramClientIsolated._(isolatedProxy);
  }

  static void _entryPoint(message) {
    hierarchicalLoggingEnabled = true;

    final isolateSpawnMessage = message as IsolateSpawnMessage;
    final init = isolateSpawnMessage.init as Init;

    final logger = Logger('TelegramClient')
      ..level = init.log.level
      ..onRecord.listen((event) {
        init.log.logExternal(event);
      });

    final tg = TelegramClient(
        logger, init.libtdjsonlcPath, init.logLevelLibTdJson, init.proxyUri);
    final isolatedDispatch = TgIsolatedDispatch(tg);

    isolateSpawnMessage.sendPort.send(isolatedDispatch.receivePort.sendPort);
  }

  @override
  Future<void> close() async {
    await isolatedProxy.call(Close());
    isolatedProxy.exit();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> login(LoginParams loginParams) async {
    return await isolatedProxy.call(Login(loginParams));
  }

  @override
  Future<void> saveChatsHistory(DateTime dateTimeFrom,
      IngesterContractParams ingesterContractParams, DbIsolated db) async {
    return await isolatedProxy
        .call(ReadChatsHistory(dateTimeFrom, ingesterContractParams, db));
  }

  @override
  Future<Message> readChatMessage(String chatName, int messageId) async {
    return await isolatedProxy.call(ReadChatMessage(chatName, messageId));
  }

  StreamController<dynamic> subscribe() {
    final receivePort = ReceivePort();
    final receivePortBroadcast = receivePort.asBroadcastStream();
    final streamController = StreamController<dynamic>();

    final isolateSubscribe = IsolateSubscribe(receivePort.sendPort);

    streamController.onCancel = () async {
      isolatedProxy.sendPort.send(IsolateUnsubscribe(isolateSubscribe));
      await Future.delayed(const Duration(milliseconds: 10));
      receivePort.close();
    };
    streamController.onListen = () {
      receivePortBroadcast.listen((message) {
        streamController.add(message);
      });
    };

    isolatedProxy.sendPort.send(isolateSubscribe);

    return streamController;
  }

  Future<dynamic> callTdFunction(TdFunction tdFunction) async {
    return await isolatedProxy.call(CallTdFunction(tdFunction));
  }

  @override
  Future<void> logout() async {
    await isolatedProxy.call(Logout());
  }
}

class TgIsolatedDispatch extends IsolatedDispatch {
  final TelegramClient tg;

  final Map<String, StreamSubscription<dynamic>> streamSubscriptions = {};

  TgIsolatedDispatch(this.tg) {}

  dynamic dispatch(message) async {
    if (message is Close) {
      for (var streamSubscription in streamSubscriptions.values) {
        await streamSubscription.cancel();
      }
      await tg.close();
    } else if (message is Login) {
      return await tg.login(message.loginParams);
    } else if (message is ReadChatsHistory) {
      return await tg.saveChatsHistory(
          message.dateTimeFrom, message.ingesterContractParams, message.db);
    } else if (message is ReadChatMessage) {
      return await tg.readChatMessage(message.chatName, message.messageId);
    } else if (message is IsolateSubscribe) {
      streamSubscriptions[message.uuid] =
          tg.tdClient.tdEvents.stream.listen((event) {
        message.replySendPort.send(event);
      });
    } else if (message is IsolateUnsubscribe) {
      await streamSubscriptions[message.uuid]?.cancel();
      streamSubscriptions.remove(message.uuid);
    } else if (message is CallTdFunction) {
      return await tg.callTdFunction(message.tdFunction);
    } else if (message is Logout) {
      await tg.logout();
    } else {
      return super.dispatch(message);
    }
  }
}

class Init {
  final LogIsolated log;
  final String libtdjsonlcPath;
  final Level logLevelLibTdJson;
  final Uri? proxyUri;

  Init(this.log, this.libtdjsonlcPath, this.logLevelLibTdJson, this.proxyUri);
}

class Close {}

class Login {
  final LoginParams loginParams;

  Login(this.loginParams);
}

class Logout {}

class ReadChatsHistory {
  DateTime dateTimeFrom;
  IngesterContractParams ingesterContractParams;
  DbIsolated db;

  ReadChatsHistory(this.dateTimeFrom, this.ingesterContractParams, this.db);
}

class ReadChatMessage {
  final String chatName;
  final int messageId;

  ReadChatMessage(this.chatName, this.messageId);
}

class IsolateSubscribe {
  final String uuid = Uuid().v4();
  final SendPort replySendPort;

  IsolateSubscribe(this.replySendPort) {}
}

class IsolateUnsubscribe {
  final String uuid;

  IsolateUnsubscribe(IsolateSubscribe isolateSubscribe)
      : uuid = isolateSubscribe.uuid {}
}

class CallTdFunction {
  final TdFunction tdFunction;

  CallTdFunction(this.tdFunction);
}

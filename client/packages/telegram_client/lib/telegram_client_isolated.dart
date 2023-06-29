import 'dart:async';
import 'isolate.dart';

import 'package:logging/logging.dart';
import 'package:td_json_client/src/td_api/object/message.dart';

import 'telegram_client_interface.dart';
import 'telegram_client.dart';
import 'log_isolated.dart';
import 'db_isolated.dart';
import 'ingester_contract.dart';

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
}

class TgIsolatedDispatch extends IsolatedDispatch {
  final TelegramClient tg;

  TgIsolatedDispatch(this.tg) {}

  dynamic dispatch(message) async {
    if (message is Close) {
      await tg.close();
    } else if (message is Login) {
      return await tg.login(message.loginParams);
    } else if (message is ReadChatsHistory) {
      return await tg.saveChatsHistory(
          message.dateTimeFrom, message.ingesterContractParams, message.db);
    } else if (message is ReadChatMessage) {
      return await tg.readChatMessage(message.chatName, message.messageId);
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

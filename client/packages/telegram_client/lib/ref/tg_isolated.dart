import 'dart:async';

import 'package:logging/logging.dart';

import 'package:telegram_client/ref/db_isolated.dart';
import 'package:telegram_client/ref/lg_isolated.dart';

import 'tg_interface.dart';
import 'ingester_contract.dart';
import 'tg.dart';
import 'isolate.dart';

class TgIsolated implements TgInterface {
  final IsolatedProxy isolatedProxy;

  TgIsolated._(
    this.isolatedProxy,
  );

  static Future<TgIsolated> spawn(
    LgIsolated lg,
    DbIsolated db,
    String libtdjsonlcPath,
    Level logLevelLibTdJson,
    Uri? proxyUri,
    IngesterContractParams ingesterContractParams, [
    String? debugName,
  ]) async {
    final init = Init(lg, db, libtdjsonlcPath, logLevelLibTdJson, proxyUri,
        ingesterContractParams);
    final sendPort =
        await Isolater.spawn(TgIsolated._entryPoint, init, debugName);
    final isolatedProxy = IsolatedProxy(sendPort);
    return TgIsolated._(isolatedProxy);
  }

  static void _entryPoint(message) {
    hierarchicalLoggingEnabled = true;

    final isolateSpawnMessage = message as IsolateSpawnMessage;
    final init = isolateSpawnMessage.init as Init;

    final logger = Logger('Tg')
      ..level = init.lg.level
      ..onRecord.listen((event) {
        init.lg.logExternal(event);
      });

    final tg = Tg(logger, init.db, init.libtdjsonlcPath, init.logLevelLibTdJson,
        init.proxyUri, init.ingesterContractParams);
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
  Future<void> saveChatsHistory(DateTime dateTimeFrom) async {
    return await isolatedProxy.call(ReadChatsHistory(dateTimeFrom));
  }
}

class TgIsolatedDispatch extends IsolatedDispatch {
  final Tg tg;

  TgIsolatedDispatch(this.tg) {}

  dynamic dispatch(message) async {
    if (message is Close) {
      return await tg.close();
    } else if (message is Login) {
      return await tg.login(message.loginParams);
    } else if (message is ReadChatsHistory) {
      return await tg.saveChatsHistory(message.dateTimeFrom);
    } else {
      return super.dispatch(message);
    }
  }
}

class Init {
  final LgIsolated lg;
  final DbIsolated db;
  final String libtdjsonlcPath;
  final Level logLevelLibTdJson;
  final Uri? proxyUri;
  final IngesterContractParams ingesterContractParams;

  Init(
    this.lg,
    this.db,
    this.libtdjsonlcPath,
    this.logLevelLibTdJson,
    this.proxyUri,
    this.ingesterContractParams,
  );
}

class Close {}

class Login {
  final LoginParams loginParams;

  Login(this.loginParams);
}

class ReadChatsHistory {
  DateTime dateTimeFrom;

  ReadChatsHistory(this.dateTimeFrom);
}

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:td_json_client/td_api.dart';
import 'package:telegram_client/ref/db_isolated.dart';

import 'package:telegram_client/ref/lg_isolated.dart';

import 'tg_interface.dart';
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
    String ingesterContractAddress,
    String ingesterContractRpcUrl,
    int ingesterContractMaxGas,
    String configPath,
    String walletPrivateKey, [
    String? debugName,
  ]) async {
    final init = Init(
      lg,
      db,
      libtdjsonlcPath,
      logLevelLibTdJson,
      proxyUri,
      ingesterContractAddress,
      ingesterContractRpcUrl,
      ingesterContractMaxGas,
      configPath,
      walletPrivateKey,
    );
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

    final tg = Tg(
      logger,
      init.db,
      init.libtdjsonlcPath,
      init.logLevelLibTdJson,
      init.proxyUri,
      init.ingesterContractAddress,
      init.ingesterContractRpcUrl,
      init.ingesterContractMaxGas,
      init.configPath,
      init.walletPrivateKey,
    );
    final isolatedDispatch = TgIsolatedDispatch(tg);

    isolateSpawnMessage.sendPort.send(isolatedDispatch.receivePort.sendPort);
  }

  @override
  Future<void> close() async {
    await isolatedProxy.call(Close());
    isolatedProxy.exit();
  }

  @override
  Future<void> login(
    int apiId,
    String apiHash,
    String phoneNumber,
    String databasePath,
    String Function() readTelegramCode,
    void Function(String p1) writeQrCodeLink,
    String Function() readUserFirstName,
    String Function() readUserLastName,
    String Function() readUserPassword,
  ) async {
    return await isolatedProxy.call(Login(
      apiId,
      apiHash,
      phoneNumber,
      databasePath,
      readTelegramCode,
      writeQrCodeLink,
      readUserFirstName,
      readUserLastName,
      readUserPassword,
    ));
  }

  @override
  FutureOr<void> saveChatsHistory() async {
    return await isolatedProxy.call(ReadChatsHistory());
  }
}

class TgIsolatedDispatch extends IsolatedDispatch {
  final Tg tg;

  TgIsolatedDispatch(this.tg) {}

  dynamic dispatch(message) async {
    if (message is Close) {
      return await tg.close();
    } else if (message is Login) {
      return await tg.login(
        message.apiId,
        message.apiHash,
        message.phoneNumber,
        message.databasePath,
        message.readTelegramCode,
        message.writeQrCodeLink,
        message.readUserFirstName,
        message.readUserLastName,
        message.readUserPassword,
      );
    } else if (message is ReadChatsHistory) {
      return await tg.saveChatsHistory();
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
  final String ingesterContractAddress;
  final String ingesterContractRpcUrl;
  final int ingesterContractMaxGas;
  final String configPath;
  final String walletPrivateKey;

  Init(
    this.lg,
    this.db,
    this.libtdjsonlcPath,
    this.logLevelLibTdJson,
    this.proxyUri,
    this.ingesterContractAddress,
    this.ingesterContractRpcUrl,
    this.ingesterContractMaxGas,
    this.configPath,
    this.walletPrivateKey,
  );
}

class Close {}

class Login {
  final int apiId;
  final String apiHash;
  final String phoneNumber;
  final String databasePath;
  final String Function() readTelegramCode;
  final void Function(String) writeQrCodeLink;
  final String Function() readUserFirstName;
  final String Function() readUserLastName;
  final String Function() readUserPassword;

  Login(
    this.apiId,
    this.apiHash,
    this.phoneNumber,
    this.databasePath,
    this.readTelegramCode,
    this.writeQrCodeLink,
    this.readUserFirstName,
    this.readUserLastName,
    this.readUserPassword,
  );
}

class ReadChatsHistory {}

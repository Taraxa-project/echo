import 'dart:async';

import 'package:logging/logging.dart';
import 'package:telegram_client/exporter.dart';

import 'exporter_interface.dart';

import 'package:telegram_client/log_isolated.dart';
import 'package:telegram_client/db_isolated.dart';

import 'ingester_contract.dart';

import 'isolate.dart';

class ExporterIsolated implements ExporterInterface {
  final IsolatedProxy isolatedProxy;

  ExporterIsolated._(this.isolatedProxy);

  static Future<ExporterIsolated> spawn(
    LogIsolated log,
    DbIsolated db,
    String tableDumpPath,
    IpfsParams ifpsParams,
    IngesterContractParams ingesterContractParams, [
    String? debugName,
  ]) async {
    final init =
        Init(log, db, tableDumpPath, ifpsParams, ingesterContractParams);
    final sendPort =
        await Isolater.spawn(ExporterIsolated._entryPoint, init, debugName);
    final isolatedProxy = IsolatedProxy(sendPort);
    return ExporterIsolated._(isolatedProxy);
  }

  static void _entryPoint(message) {
    hierarchicalLoggingEnabled = true;

    final isolateSpawnMessage = message as IsolateSpawnMessage;
    final init = isolateSpawnMessage.init as Init;

    final logger = Logger('Exporter')
      ..level = init.log.level
      ..onRecord.listen((event) {
        init.log.logExternal(event);
      });
    final exporter = Exporter(logger, init.db, init.tableDumpPath,
        init.ifpsParams, init.ingesterContractParams);
    final isolatedDispatch = ExporterIsolatedDispatch(exporter);

    isolateSpawnMessage.sendPort.send(isolatedDispatch.receivePort.sendPort);
  }

  void exit() {
    isolatedProxy.exit();
  }

  @override
  Future<void> export() async {
    await isolatedProxy.call(Export());
  }

  @override
  Future<void> unpinOld() async {
    await isolatedProxy.call(UnpinOld());
  }
}

class ExporterIsolatedDispatch extends IsolatedDispatch {
  final Exporter exporter;

  ExporterIsolatedDispatch(this.exporter) {}

  dynamic dispatch(message) async {
    if (message is Export) {
      await exporter.export();
    } else if (message is UnpinOld) {
      await exporter.unpinOld();
    } else {
      return super.dispatch(message);
    }
  }
}

class Init {
  final LogIsolated log;
  final DbIsolated db;
  final String tableDumpPath;
  final IpfsParams ifpsParams;
  final IngesterContractParams ingesterContractParams;

  Init(
    this.log,
    this.db,
    this.tableDumpPath,
    this.ifpsParams,
    this.ingesterContractParams,
  );
}

class Export {}

class UnpinOld {}

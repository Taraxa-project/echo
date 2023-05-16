import 'dart:async';

import 'package:logging/logging.dart';
import 'package:telegram_client/exporter.dart';

import 'exporter_interface.dart';

import 'package:telegram_client/log_isolated.dart';
import 'package:telegram_client/db_isolated.dart';
import 'package:cron/cron.dart';

import 'ingester_contract.dart';

import 'isolate.dart';

class ExporterIsolated implements ExporterInterface {
  final IsolatedProxy isolatedProxy;

  ExporterIsolated._(this.isolatedProxy);

  static Future<ExporterIsolated> spawn(
    LogIsolated log,
    DbIsolated db,
    String cronFormat,
    Schedule schedule,
    String tableDumpPath,
    IpfsParams ifpsParams,
    IngesterContractParams ingesterContractParams, [
    String? debugName,
  ]) async {
    final init = Init(log, db, cronFormat, schedule, tableDumpPath, ifpsParams,
        ingesterContractParams);
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
    final exporter = Exporter(logger, init.db, init.cronFormat, init.schedule,
        init.tableDumpPath, init.ifpsParams, init.ingesterContractParams);
    final isolatedDispatch = IpfsIsolatedDispatch(exporter);

    isolateSpawnMessage.sendPort.send(isolatedDispatch.receivePort.sendPort);
  }

  void exit() {
    isolatedProxy.exit();
  }
}

class IpfsIsolatedDispatch extends IsolatedDispatch {
  final Exporter ipfs;

  IpfsIsolatedDispatch(this.ipfs) {}
}

class Init {
  final LogIsolated log;
  final DbIsolated db;
  final String cronFormat;
  final Schedule schedule;
  final String tableDumpPath;
  final IpfsParams ifpsParams;
  final IngesterContractParams ingesterContractParams;

  Init(
    this.log,
    this.db,
    this.cronFormat,
    this.schedule,
    this.tableDumpPath,
    this.ifpsParams,
    this.ingesterContractParams,
  );
}

class Export {}

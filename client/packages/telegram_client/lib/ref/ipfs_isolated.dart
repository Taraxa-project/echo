import 'dart:async';

import 'package:logging/logging.dart';
import 'package:telegram_client/ref/ipfs.dart';

import 'ipfs_interface.dart';

import 'package:telegram_client/ref/lg_isolated.dart';
import 'package:telegram_client/ref/db_isolated.dart';
import 'package:cron/cron.dart';

import 'ingester_contract.dart';

import 'isolate.dart';

class IpfsIsolated implements IpfsInterface {
  final IsolatedProxy isolatedProxy;

  IpfsIsolated._(this.isolatedProxy);

  static Future<IpfsIsolated> spawn(
    LgIsolated lg,
    DbIsolated db,
    String cronFormat,
    Schedule schedule,
    String tableDumpPath,
    IpfsParams ifpsParams,
    IngesterContractParams ingesterContractParams, [
    String? debugName,
  ]) async {
    final init = Init(lg, db, cronFormat, schedule, tableDumpPath, ifpsParams,
        ingesterContractParams);
    final sendPort =
        await Isolater.spawn(IpfsIsolated._entryPoint, init, debugName);
    final isolatedProxy = IsolatedProxy(sendPort);
    return IpfsIsolated._(isolatedProxy);
  }

  static void _entryPoint(message) {
    hierarchicalLoggingEnabled = true;

    final isolateSpawnMessage = message as IsolateSpawnMessage;
    final init = isolateSpawnMessage.init as Init;

    final logger = Logger('Ipfs')
      ..level = init.lg.level
      ..onRecord.listen((event) {
        init.lg.logExternal(event);
      });
    final ipfs = Ipfs(logger, init.db, init.cronFormat, init.schedule,
        init.tableDumpPath, init.ifpsParams, init.ingesterContractParams);
    final isolatedDispatch = IpfsIsolatedDispatch(ipfs);

    isolateSpawnMessage.sendPort.send(isolatedDispatch.receivePort.sendPort);
  }

  void exit() {
    isolatedProxy.exit();
  }

  @override
  Future<void> export() async {
    await isolatedProxy.call(Export());
  }
}

class IpfsIsolatedDispatch extends IsolatedDispatch {
  final Ipfs ipfs;

  IpfsIsolatedDispatch(this.ipfs) {}
}

class Init {
  final LgIsolated lg;
  final DbIsolated db;
  final String cronFormat;
  final Schedule schedule;
  final String tableDumpPath;
  final IpfsParams ifpsParams;
  final IngesterContractParams ingesterContractParams;

  Init(
    this.lg,
    this.db,
    this.cronFormat,
    this.schedule,
    this.tableDumpPath,
    this.ifpsParams,
    this.ingesterContractParams,
  );
}

class Export {}

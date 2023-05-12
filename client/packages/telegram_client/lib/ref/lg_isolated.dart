import 'dart:async';

import 'package:logging/logging.dart';

import 'isolate.dart';
import 'lg_interface.dart';
import 'lg.dart';

class LgIsolated implements LgInterface {
  final IsolatedProxy isolatedProxy;
  final Level? level;

  LgIsolated._(this.isolatedProxy, this.level);

  static Future<LgIsolated> spawn([Level? level, String? debugName]) async {
    final init = Init(level);
    final sendPort =
        await Isolater.spawn(LgIsolated._entryPoint, init, debugName);
    final isolatedProxy = IsolatedProxy(sendPort);
    return LgIsolated._(isolatedProxy, level);
  }

  static void _entryPoint(message) {
    hierarchicalLoggingEnabled = true;

    final isolateSpawnMessage = message as IsolateSpawnMessage;
    final init = isolateSpawnMessage.init as Init;

    final isolatedDispatch = LgIsolatedDispatch(Lg(init.level));

    isolateSpawnMessage.sendPort.send(isolatedDispatch.receivePort.sendPort);
  }

  void exit() {
    isolatedProxy.exit();
  }

  @override
  void logExternal(LogRecord logRecord) {
    isolatedProxy.sendPort.send(logRecord);
  }
}

class LgIsolatedDispatch extends IsolatedDispatch {
  final Lg lg;

  LgIsolatedDispatch(this.lg) {}

  dynamic dispatch(message) {
    if (message is LogRecord) {
      lg.logExternal(message);
    } else {
      return super.dispatch(message);
    }
  }
}

class Init {
  final Level? level;
  Init([this.level]);
}

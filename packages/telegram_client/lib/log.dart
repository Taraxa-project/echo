import 'package:logging/logging.dart';

import 'isolate.dart';

class Log extends Isolated {
  Log({
    super.logLevel,
  }) {
    logger.onRecord.listen((event) {
      if (event.object != null && event.object is LogRecord) {
        log(event.object as LogRecord);
      } else {
        log(event);
      }
    });
  }

  void initDispatch() {
    receivePort.listen((message) {
      if (message is IsolateMsgRequestExit) {
        logger.fine('exiting...');
        exit(message.replySendPort);
      } else if (message is LogRecord) {
        logExternal(message);
      }
    });
  }

  void logExternal(LogRecord logRecord) {
    logger.log(logRecord.level, logRecord);
  }

  void log(LogRecord logRecord) {
    print(logRecord);
  }
}

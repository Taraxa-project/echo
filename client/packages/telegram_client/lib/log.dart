import 'package:logging/logging.dart';

class Log {
  late final Logger logger;

  Log([Level? level]) {
    logger = Logger('Lg')
      ..level = level
      ..onRecord.listen((event) {
        _log(event);
      });
  }

  void logExternal(LogRecord logRecord) {
    logger.log(logRecord.level, logRecord);
  }

  void _log(event) {
    if (event.object is LogRecord) {
      _handle(event.object as LogRecord);
    } else {
      _handle(event);
    }
  }

  void _handle(event) {
    print(event);
  }
}

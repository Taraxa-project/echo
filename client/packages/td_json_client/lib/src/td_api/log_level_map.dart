import 'package:logging/logging.dart';
import 'package:quiver/collection.dart';

/// Map for logging log levels and TDLib log levels
class LogLevelMap {
  BiMap _map = BiMap();

  LogLevelMap() {
    _map[1] = Level.SEVERE;
    _map[2] = Level.WARNING;
    _map[3] = Level.INFO;
    _map[4] = Level.FINE;
    _map[5] = Level.FINER;
  }

  /// Convert TDLib log level to logging log level
  Level fromTd(int verbosityLevel) {
    if (verbosityLevel == 0) return Level.SEVERE;
    return _map[verbosityLevel] ?? Level.ALL;
  }

  /// Convert loggin log level to TDLib log level
  int toTd(Level? level) {
    return _map.inverse[level] ?? 6;
  }

  /// Convenient key to convert from log levels
  static LogLevelMap MAP = LogLevelMap();
}

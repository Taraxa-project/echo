import 'package:args/command_runner.dart';
import 'package:loggy/loggy.dart';

mixin TelegramCommandLoggy implements LoggyType {
  @override
  Loggy<TelegramCommandLoggy> get loggy =>
      Loggy<TelegramCommandLoggy>('Echo - $runtimeType');

  void setLogLevel(String logLevelName) {
    loggy.level = LogOptions(LogLevel.values.firstWhere(
        (element) => element.name == logLevelName,
        orElse: () => LogLevel.all));
  }
}

abstract class TelegramCommand extends Command with TelegramCommandLoggy {}

import 'package:args/command_runner.dart';
import 'package:loggy/loggy.dart';

mixin TelegramCommandLoggy implements LoggyType {
  @override
  Loggy<TelegramCommandLoggy> get loggy =>
      Loggy<TelegramCommandLoggy>('Echo - $runtimeType');
}

abstract class TelegramCommand extends Command with TelegramCommandLoggy {
  void initLogger() {
    var logLevel = LogLevel.values.firstWhere(
        (element) => element.name == globalResults!['loglevel'],
        orElse: () => LogLevel.all);
    var logOptions = LogOptions(logLevel);

    Loggy.initLoggy(logPrinter: const PrettyPrinter(), logOptions: logOptions);
  }
}

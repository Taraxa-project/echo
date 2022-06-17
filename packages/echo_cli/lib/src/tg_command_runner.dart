import 'package:args/command_runner.dart';

class TelegramCommandRunner<T> extends CommandRunner<T> {
  late final String Function() readTelegramCode;

  TelegramCommandRunner(super.executableName, super.description);
}

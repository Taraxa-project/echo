import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:echo_cli/command_signup.dart';

void main(List<String> arguments) {
  final CommandRunner commandRunner =
      CommandRunner("echo", "A dart implementation of Telegram scrapper.");
  commandRunner.argParser
    ..addOption('api-id',
        mandatory: true,
        help: 'Telegram api_id (https://my.telegram.org/apps/)')
    ..addOption('api-hash',
        mandatory: true,
        help: 'Telegram api_hash (https://my.telegram.org/apps/)')
    ..addOption('phone-number', mandatory: true, help: 'Your phone number')
    ..addOption('libtdjson-path', mandatory: true, help: 'libtdjson full path')
    ..addOption('proxy');
  commandRunner
    ..addCommand(CommandSignup())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}

import 'dart:io';

import 'package:args/args.dart';
import 'package:loggy/loggy.dart';

import 'grammar.dart';
import 'tl.dart';
import 'td.dart';

Future<void> main(List<String> arguments) async {
  initLoggy();

  var options = getOptions(arguments);

  var parseResults = TlGrammarDefinition()
      .build()
      .parse(await File(options['tl-schema-path']).readAsString());

  if (parseResults.isFailure) {
    logWarning('Parse error: ${parseResults.message}');
    exit(-1);
  }

  await Api(
    tdApiPath: options['td-api-path'],
    package: options['package'],
  )
    ..addTls(parseResults.value.cast<Tl>())
    ..writeFiles();
}

void initLoggy() {
  Loggy.initLoggy(
      logPrinter: const PrettyPrinter(),
      logOptions: defaultLevel,
      hierarchicalLogging: true);
}

ArgResults getOptions(List<String> arguments) {
  var argParser = ArgParser()
    ..addOption(
      'tl-schema-path',
      mandatory: true,
      help:
          'The path to Telegram TL schema (see https://github.com/tdlib/td/blob/v1.8.0/td/generate/scheme/td_api.tl)',
    )
    ..addOption(
      'td-api-path',
      mandatory: true,
      help: 'Folder location where the TD API classes are generated',
    )
    ..addOption(
      'package',
      mandatory: true,
      help: 'Package name (used to generate imports)',
    );
  return argParser.parse(arguments);
}

import 'dart:io';

import 'package:args/args.dart';

import 'grammar.dart';
import 'tl.dart';
import 'td.dart';

Future<void> main(List<String> arguments) async {
  var options = getOptions(arguments);

  var parseResults = TlGrammarDefinition()
      .build()
      .parse(await File(options['tl-schema-path']).readAsString());

  if (parseResults.isFailure) {
    print('Parse error: ${parseResults.message}');
    exit(-1);
  }

  await Api(
    tdApiPath: options['td-api-path'],
    package: options['package'],
    tlObjects: parseResults.value[0].cast<TlObject>(),
    tlFunctions: parseResults.value[1].cast<TlFunction>(),
  )
    ..prepareOutput()
    ..writeFiles();
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

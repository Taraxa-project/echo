import 'dart:io';

import 'package:args/args.dart';
import 'package:loggy/loggy.dart';
import 'package:petitparser/petitparser.dart';
import 'package:mustache_template/mustache.dart';
import 'package:recase/recase.dart';

void main(List<String> arguments) async {
  Loggy.initLoggy(
      logPrinter: const PrettyPrinter(),
      logOptions: defaultLevel,
      hierarchicalLogging: true);

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
    );
  var options = argParser.parse(arguments);

  var parseResult = TlGrammarDefinition()
      .build()
      .parse(await File(options['tl-schema-path']).readAsString());
  if (parseResult.isFailure) {
    logWarning('Parse error: ${parseResult.message}');
    exit(-1);
  }
  generateClass({
    'classes': [
      prepareTlObject(parseResult.value[2].last),
    ],
  });
  // print(parseResult.value);
}

class TlGrammarDefinition extends GrammarDefinition {
  Parser newline = Token.newlineParser();

  Parser start() => ref0(term).end();

  Parser term() =>
      (ref0(definitionWithComments) | ref0(switchToFunctions)).star();

  Parser definitionWithComments() => ref0(commments).star() & ref0(definition);

  Parser commments() => ref0(comment) | newline;
  Parser comment() =>
      (string('//') & noneOf('\n\r').star().flatten() & newline.star())
          .flatten()
          .map((value) => value);

  Parser definition() => (ref0(definitionName) &
          ref0(definitionParam).star() &
          (char('=') & whitespace().plus()) &
          ref0(definitionResultType))
      .map((value) => TlDefinition(
            name: value[0],
            params: value[1].cast<TlParam>(),
            returnType: value[3],
          ));
  Parser definitionName() =>
      (noneOf('\n\r-/ ').plus().flatten() & whitespace().plus())
          .map((value) => value[0]);
  Parser definitionParam() =>
      (ref0(definitionParamName) & ref0(definitionParamType))
          .map((value) => TlParam(
                name: value[0],
                type: value[1],
              ));
  Parser definitionParamName() =>
      (noneOf(':=').plus().flatten() & char(':')).map((value) => value[0]);
  Parser definitionParamType() =>
      (noneOf(' ').plus().flatten() & whitespace().plus())
          .map((value) => TlType(
                name: value[0],
              ));
  Parser definitionResultType() =>
      (noneOf(';').plus().flatten() & char(';') & newline.star())
          .map((value) => TlType(name: value[0]));

  Parser switchToFunctions() =>
      (string('---functions---') & newline.star()).map((value) => value);
}

class TlObject {}

class TlSwitch extends TlObject {}

class TlComment extends TlObject {
  String text;
  TlComment({
    required this.text,
  });
}

class TlType extends TlObject {
  String name;
  TlType({
    required this.name,
  });
  bool get isPrimitive => [
        'double',
        'string',
        'int32',
        'int53',
        'int64',
        'bytes',
        'Bool',
        'String'
      ].contains(name);
  bool get isVector => false;
}

class TlTypeVector extends TlType {
  String subtype;
  TlTypeVector({required super.name, required String this.subtype});
  bool get isVector => true;
}

class TlDefinition {
  String name;
  List<TlParam> params;
  TlType returnType;
  TlDefinition({
    required this.name,
    required this.params,
    required this.returnType,
  });
}

class TlParam extends TlObject {
  String name;
  TlType type;
  TlParam({
    required this.name,
    required this.type,
  });
}

Map<String, dynamic> prepareTlObject(TlDefinition tlDefinition) {
  Map<String, dynamic> map = {
    'name': tlDefinition.name,
    'className': ReCase(tlDefinition.name).pascalCase,
    'isAbstract': false,
    'extends': 'TlObject',
    'members': tlDefinition.params.map((param) => {
          'type': param.type.name,
          'name': param.name,
        }),
  };
  return map;
}

String generateClass(Map<String, dynamic> map) {
  var source = '''
{{# classes }}
{{# isAbstract }}abstract {{/ isAbstract }}class {{ className }} extends {{ extends }} {
  
  {{! class members }}
  {{# members }}
  {{ type }}? {{ name }};
  {{/ members }}

  {{^ isAbstract }}
  {{! default constructor }}
  {{ className }}({
    {{# members }}
    this.{{ name }},
    {{/ members }}
  });
  {{/ isAbstract }}
}
{{/ classes }}
''';
  final template = Template(source);
  final output = template.renderString(map);
  print(output);
  return output;
}

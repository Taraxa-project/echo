import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:args/args.dart';
import 'package:loggy/loggy.dart';
import 'package:petitparser/petitparser.dart';
import 'package:mustache_template/mustache.dart';
import 'package:recase/recase.dart';

enum ParseType { object, function }

Future<void> main(List<String> arguments) async {
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
    )
    ..addOption(
      'package',
      mandatory: true,
      help: 'Package name (used to generate imports)',
    );
  var options = argParser.parse(arguments);

  var parseResults = TlGrammarDefinition()
      .build()
      .parse(await File(options['tl-schema-path']).readAsString());
  if (parseResults.isFailure) {
    logWarning('Parse error: ${parseResults.message}');
    exit(-1);
  }

  Map<String, TdTypes> tdApiTypes = {};
  var tdApiMap = TdApiMap();

  var parseType = ParseType.object;

  for (var parseResult in parseResults.value) {
    if (parseResult is TlSwitch) {
      parseType = ParseType.function;
      continue;
    }

    var tlDefinition = parseResult.last as TlDefinition;

    tdApiMap.map[tlDefinition.name] = TdApi(
        name: tlDefinition.name,
        type: tlDefinition.className,
        isFunction: parseType == ParseType.function);

    var tdTypesKey = parseType == ParseType.object
        ? tlDefinition.returnType.name
        : tlDefinition.className;
    tdApiTypes.putIfAbsent(tdTypesKey,
        () => TdTypes(hasFunctions: parseType == ParseType.function));

    if (parseType == ParseType.function) {
      tlDefinition.isFunction = true;
      tlDefinition.superClassName = 'TdFunction';
    } else {
      if (tlDefinition.className != tlDefinition.returnType.name) {
        tlDefinition.superClassName = tlDefinition.returnType.name;
        tdApiTypes[tdTypesKey]?.tlDefitions.putIfAbsent(
            tlDefinition.superClassName,
            () => TlDefinition(
                name: tlDefinition.returnType.name,
                params: [],
                returnType: tlDefinition.returnType,
                isAbstract: true));
      }
    }

    tlDefinition.imports.add('package:${options['package']}/api/base.dart');
    tlDefinition.imports.add('package:${options['package']}/api/map.dart');
    for (var param in tlDefinition.params) {
      if (!param.type.isPrimitive) {
        tlDefinition.imports.add(
            'package:${options['package']}/api/object/${ReCase(param.type.name).snakeCase}.dart');
      }
    }

    tdApiTypes[tdTypesKey]
        ?.tlDefitions
        .putIfAbsent(tlDefinition.className, () => tlDefinition);
  }

  await writeFiles(
      options['td-api-path'], options['package'], tdApiMap, tdApiTypes);
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
      (string('---functions---') & newline.star()).map((value) => TlSwitch());
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

  String className;
  String superClassName;

  bool isAbstract;
  bool isFunction;

  List<String> imports = [];

  TlDefinition({
    required this.name,
    required this.params,
    required this.returnType,
    this.superClassName = 'TdObject',
    this.isAbstract = false,
    this.isFunction = false,
  }) : className = ReCase(name).pascalCase {}

  Map<String, dynamic> toTemplateMap() {
    Map<String, dynamic> map = {
      'name': name,
      'className': className,
      'isAbstract': isAbstract,
      'isFunction': isFunction,
      'superClassName': superClassName,
      'returnType': returnType.name,
      'imports': imports.map((import) => {
            'value': import,
          }),
      'members': params.map((param) => {
            'type': param.type.isPrimitive
                ? param.type.name
                : ReCase(param.type.name).pascalCase,
            'name': param.name,
            'isPrimitive': param.type.isPrimitive,
            'isVector': param.type.isVector,
          }),
    };
    return map;
  }
}

class TlParam extends TlObject {
  String name;
  TlType type;
  TlParam({
    required this.name,
    required this.type,
  });
}

class TdTypes {
  bool hasFunctions;
  Map<String, TlDefinition> tlDefitions = {};
  TdTypes({required this.hasFunctions});
}

class TdApi {
  String name;
  String type;
  bool isFunction;
  TdApi({
    required this.name,
    required this.type,
    required this.isFunction,
  });
}

class TdApiMap {
  Map<String, TdApi> map = {};
}

Future<void> writeFiles(
  String path,
  String package,
  TdApiMap tdApiMap,
  Map<String, TdTypes> tdApiTypes,
) async {
  var finalPath = p.joinAll([path, 'api']);
  await Directory(finalPath).create(recursive: true);

  var filePath = p.joinAll([finalPath, 'base.dart']);
  await File(filePath).writeAsString(generateBase());

  var objectPath = p.joinAll([finalPath, 'object']);
  await Directory(objectPath).create(recursive: true);

  var functionPath = p.joinAll([finalPath, 'function']);
  await Directory(functionPath).create(recursive: true);

  Map<String, List<String>> all = {
    'object': [],
    'function': [],
  };

  for (var result in generate(tdApiTypes)) {
    if (result['hasFunctions']) {
      filePath = p.joinAll([
        functionPath,
        "${result['fileName']}.dart",
      ]);
      all['function']?.add(
          "import 'package:$package/api/function/${result['fileName']}.dart';");
    } else {
      filePath = p.joinAll([
        objectPath,
        "${result['fileName']}.dart",
      ]);
      all['object']?.add(
          "import 'package:$package/api/object/${result['fileName']}.dart';");
    }

    await File(filePath).writeAsString(result['fileContent']);
  }

  // var objectAllContent = all['object']?.join('\n');
  // var objectAllPath = p.joinAll([objectPath, 'all.dart']);
  // await File(objectAllPath).writeAsString(objectAllContent! + '\n');

  // var functionAllContent = all['function']?.join('\n');
  // var functionAllPath = p.joinAll([functionPath, 'all.dart']);
  // await File(functionAllPath).writeAsString(functionAllContent! + '\n');

  // var allPath = p.joinAll([finalPath, 'all.dart']);
  // await File(allPath).writeAsString([
  //       "import 'package:$package/api/object/all.dart';",
  //       "import 'package:$package/api/function/all.dart';",
  //     ].join('\n') +
  //     '\n');

  filePath = p.joinAll([finalPath, 'map.dart']);
  await File(filePath).writeAsString(generatetTdMap(package, tdApiMap));
}

List<dynamic> generate(Map<String, TdTypes> tdTApiTypes) {
  var source = '''
{{# classes }}
{{# imports }}
import '{{ value }}';
{{/ imports }}

{{# isAbstract }}abstract {{/ isAbstract }}class {{ className }} extends {{ superClassName }} {
{{^ isAbstract }}
  
  {{! properties }}
  String get tdType => '{{ name }}';
  {{# isFunction }}
  String get tdReturnType => '{{ returnType }}';
  {{/ isFunction }}

  {{! class members }}
  string? extra;
  int? client_id;

  {{# members }}
  {{ type }}? {{ name }};
  {{/ members }}

  {{! default constructor }}
  {{ className }}({
    this.extra,
    this.client_id,
    {{# members }}
    this.{{ name }},
    {{/ members }}
  });

  {{! fromMap }}
  {{ className }}.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    {{# members }}
    {{# isPrimitive }}
    {{ name }} = map['{{ name }}'];
    {{/ isPrimitive }}
    {{^ isPrimitive }}
    {{ name }} = TdApiMap.fromMap(map['{{ name }}']) as {{ type }};
    {{/ isPrimitive }}
    {{/ members }}
  }

  {{! toMap }}
  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      {{# members }}
      '{{ name }}': {{ name }}?.toMap(skipNulls: skipNulls),
      {{/ members }}
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
{{/ isAbstract }}
}

{{/ classes }}
''';

  final template = Template(source, htmlEscapeValues: false);
  var result = [];
  tdTApiTypes.forEach((key, tdTypes) => result.add({
        'fileName': ReCase(key).snakeCase,
        'hasFunctions': tdTypes.hasFunctions,
        'fileContent': template.renderString({
          'classes': tdTypes.tlDefitions.values.map((e) => e.toTemplateMap())
        }),
      }));
  return result;
}

String generateBase() {
  return '''
import 'dart:convert';

typedef Bool = bool;
typedef int32 = int;
typedef int53 = int;
typedef int64 = String;
typedef vector<T> = List<T>;
typedef bytes = String;
typedef string = String;

extension BoolMap on bool {
  bool toMap({skipNulls: true}) => this;
}

extension IntMap on int {
  int toMap({skipNulls: true}) => this;
}

extension DoubleMap on double {
  double toMap({skipNulls: true}) => this;
}

extension StringMap on String {
  String toMap({skipNulls: true}) => this;
}

extension ListMap on List {
  List toMap({skipNulls: true}) => this;
}

abstract class TlObject {
  String get tdType;

  TlObject();
  TlObject.fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap({skipNulls: true});

  String toJson({skipNulls = true}) {
    return jsonEncode(toMap(skipNulls: skipNulls));
  }

  String toString({skipNulls = false}) {
    return toJson(skipNulls: skipNulls);
  }
}

abstract class TdObject extends TlObject {}

abstract class TdFunction extends TlObject {
  String get tdReturnType;
}

''';
}

String generatetTdMap(
  String package,
  TdApiMap tdApiMap,
) {
  var source = '''
{{ import_base  }}
{{# imports }}
{{ value }}
{{/ imports }}

class TdApiMap {
  static Map<String, dynamic Function(Map<String, dynamic>)> _tdMap = {
    {{# map }}
    '{{ name }}': (map) => {{ type }}.fromMap(map),
    {{/ map }}
  }

  static TlObject? fromMap(Map<String, dynamic> map) {
    return _tdMap.containsKey(map['@type']) ? _tdMap[map['@type']]!(map) : null;
  }
}
''';

  final template = Template(source, htmlEscapeValues: false);
  return template.renderString({
    'import_base': "import 'package:$package/api/base.dart';",
    'imports': tdApiMap.map.values.map((tdApi) => {
          'value':
              "import 'package:$package/api/${tdApi.isFunction ? 'function' : 'object'}/${ReCase(tdApi.type).snakeCase}.dart';",
        }),
    'map': tdApiMap.map.values.map((tdApi) => {
          'name': tdApi.name,
          'type': tdApi.type,
          'import':
              "import 'package:$package/api/${tdApi.isFunction ? 'function' : 'object'}/${tdApi.type}.dart';",
        }),
  });
}

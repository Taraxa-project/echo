import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:mustache_template/mustache.dart';

import 'tl.dart';

class Api {
  String tdApiPath;
  String package;
  List<TlObject> tlObjects;
  List<TlFunction> tlFunctions;

  Api(
      {required this.tdApiPath,
      required this.package,
      required this.tlObjects,
      required this.tlFunctions});

  String get apiPath => path.joinAll([tdApiPath, 'api']);
  String get basePath => path.joinAll([apiPath, 'base.dart']);
  String get mapPath => path.joinAll([apiPath, 'map.dart']);
  String get objectPath => path.joinAll([tdApiPath, 'api', 'object']);
  String get functionPath => path.joinAll([tdApiPath, 'api', 'function']);

  Map<String, TdFile> _tdFiles = {};
  Map<String, String> _typeToFile = {};

  void prepareOutput() {
    tlObjects.forEach((element) {
      _prepareObject(element);
    });
    tlFunctions.forEach((element) {
      _prepareFunction(element);
    });
  }

  void _prepareObject(TlObject tlObject) {
    _addTypeToFile(tlObject, 'object');
    var tdFile = _tdFiles.putIfAbsent(
        tlObject.superClassName,
        () => TdFile(
              typeName: tlObject.superClassName,
              dirPath: objectPath,
              package: package,
              packageFilePath: path.joinAll(['api', 'object']),
            ));
    if (!tlObject.extendsBase) {
      tdFile.classes.putIfAbsent(
          tlObject.superClassName,
          () => Td(
                className: tlObject.superClassName,
                superClassName: 'TdObject',
                isAbstract: true,
              ));
    }
    tdFile.processTlDefinition(tlObject);
  }

  void _prepareFunction(TlFunction tlFunction) {
    _addTypeToFile(tlFunction, 'function');
    var tdFile = _tdFiles.putIfAbsent(
        tlFunction.className,
        () => TdFile(
              typeName: tlFunction.className,
              dirPath: functionPath,
              package: package,
              packageFilePath: path.joinAll(['api', 'function']),
            ));
    tdFile.processTlDefinition(tlFunction);
  }

  void _addTypeToFile(TlDefinition tlDefinition, String dir) {
    _typeToFile.putIfAbsent(tlDefinition.className,
        () => path.joinAll([dir, tlDefinition.fileName]));
  }

  Future<void> writeFiles() async {
    await createDirectories();

    await writeMap();
    await writeBase();
    await writeApi();
  }

  Future<void> createDirectories() async {
    await Directory(apiPath).create(recursive: true);
    await Directory(objectPath).create(recursive: true);
    await Directory(functionPath).create(recursive: true);
  }

  Future<void> writeBase() async {
    await File(basePath).writeAsString(
        Template(TdFile.baseTemplate, htmlEscapeValues: false)
            .renderString({}));
  }

  Future<void> writeMap() async {
    Map<String, dynamic> map = {
      'package': {'value': package},
      'imports': [],
      'map': []
    };
    Map<String, dynamic> imports = {};
    for (var key in _typeToFile.keys) {
      imports[_typeToFile[key]!] = {
        'value': "import 'package:$package/api/${_typeToFile[key]}.dart';"
      };
      map['map'].add({
        'name': ReCase(key).camelCase,
        'type': key,
      });
    }
    map['imports'] = imports.values;
    await File(mapPath).writeAsString(
        Template(TdFile.mapTemplate, htmlEscapeValues: false)
            .renderString(map));
  }

  Future<void> writeApi() async {
    for (var className in _tdFiles.keys) {
      var tdFile = _tdFiles[className]!;
      await File(path
              .joinAll([tdFile.dirPath, '${ReCase(className).snakeCase}.dart']))
          .writeAsString(Template(TdFile.tdTemplate, htmlEscapeValues: false)
              .renderString(tdFile.toMap()));
    }
  }
}

class TdFile {
  String package;
  String dirPath;
  String packageFilePath;
  String typeName;
  Map<String, String> imports = {};
  Map<String, Td> classes = {};
  bool usesMap = false;
  TdFile(
      {required this.typeName,
      required this.dirPath,
      required this.package,
      required this.packageFilePath});

  void processTlDefinition(TlDefinition tlDefinition) {
    var td = classes.putIfAbsent(
        tlDefinition.className,
        () => Td(
              className: tlDefinition.className,
              superClassName: tlDefinition.extendsClasName,
              isFunction: tlDefinition.isFunction,
              returnType: tlDefinition.returnType,
              members: [],
            ));
    tlDefinition.constructor.params.forEach((tlParam) {
      var tdMember = TdMember(
        type: tlParam.type.tdName,
        name: tlParam.name,
        isPrimitive: true,
        isVector: tlParam.type.isVector,
        isVectorVector: tlParam.type.isVectorVector,
      );
      if (!tlParam.type.isPrimitive &&
          !TlPrimitives.primitives.contains(tlParam.type.tdSubName)) {
        if (this.typeName != tlParam.type.tdSubName) {
          imports[tlParam.type.tdSubName] = tlParam.type.tdSubName;
          usesMap = true;
          tdMember.isPrimitive = false;
        }
      }
      tdMember.subName = tlParam.type.tdSubName;
      td.members.add(tdMember);
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'package': {'value': package},
      'imports': imports.values.map((e) => {
            'value':
                "import 'package:$package/api/object/${ReCase(e).snakeCase}.dart';",
          }),
      'classes': classes.values.map((td) => td.toMap()),
      'usesMap': usesMap,
    };
  }

  static String get baseTemplate => '''
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

abstract class Td {
  String get tdType;

  Td();
  Td.fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap({skipNulls: true});

  String toJson({skipNulls = true}) {
    return jsonEncode(toMap(skipNulls: skipNulls));
  }

  String toString({skipNulls = false}) {
    return toJson(skipNulls: skipNulls);
  }
}

abstract class TdObject extends Td {}

abstract class TdFunction extends Td {
  String get tdReturnType;
}
''';

  static String get tdTemplate => '''
import 'package:{{# package }}{{ value }}{{/ package }}/api/base.dart';
{{# usesMap }}
import 'package:{{# package }}{{ value }}{{/ package }}/api/map.dart';
{{/ usesMap }}
{{# imports }}
{{ value }}
{{/ imports }}

{{# classes }}
{{# isAbstract }}
abstract class {{ className }} extends {{ extendsClassName }} {}

{{/ isAbstract }}
{{^ isAbstract}}
class {{ className }} extends {{ extendsClassName }} {
  {{! properties }}
  String get tdType => '{{ tdType }}';
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

  {{! fromMap constructor}}
  {{ className }}.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    {{# members }}
    {{# isContainer }}
    if (map['{{ name }}']) {
      {{ name }} = [];
      {{# isVector }}
      for (var someValue in map['{{ name }}']) {
        {{#isPrimitive}}
        {{ name }}?.add(someValue);
        {{/isPrimitive}}
        {{^isPrimitive}}
        {{ name }}?.add(TdApiMap.fromMap(someValue) as {{ subName }});
        {{/isPrimitive}}
      }
      {{/ isVector }}
      {{# isVectorVector }}
      for (var someValues in map['{{ name }}']) {
        var objs = <{{ subName }}>[];
        for (var someValue in someValues) {
          {{#isPrimitive}}
          objs?.add(someValue);
          {{/isPrimitive}}
          {{^isPrimitive}}
          objs.add(TdApiMap.fromMap(someValue) as {{ subName }});
          {{/isPrimitive}}
        }
        {{name}}?.add(objs);
      }
      {{/ isVectorVector }}
    }
    {{/ isContainer }}
    {{^ isContainer }}
    {{# isPrimitive }}
    {{ name }} = map['{{ name }}'];
    {{/ isPrimitive }}
    {{^ isPrimitive }}
    {{ name }} = TdApiMap.fromMap(map['{{ name }}']) as {{ subName }};
    {{/ isPrimitive }}
    {{/ isContainer }}
    {{/ members }}
  }

  {{! toMap}}
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
}
{{/ isAbstract }}
{{/ classes }}
''';

  static String get mapTemplate => '''
import 'package:{{# package }}{{ value }}{{/ package }}/api/base.dart';

{{# imports }}
{{ value }}
{{/ imports }}

class TdApiMap {
  static Map<String, dynamic Function(Map<String, dynamic>)> _tdMap = {
    {{# map }}
    '{{ name }}': (map) => {{ type }}.fromMap(map),
    {{/ map }}
  };

  static Td? fromMap(Map<String, dynamic> map) {
    return _tdMap.containsKey(map['@type']) ? _tdMap[map['@type']]!(map) : null;
  }
}
''';
}

class Td {
  String className;
  String superClassName;
  bool isAbstract;
  bool isFunction;
  String returnType;
  List<TdMember> members = [];

  Td({
    required this.className,
    required this.superClassName,
    this.isAbstract = false,
    this.isFunction = false,
    this.returnType = '',
    this.members = const [],
  });
  Map<String, dynamic> toMap() {
    var map = {
      'className': className,
      'extendsClassName': superClassName,
      'isAbstract': isAbstract,
      'isFunction': isFunction,
      'tdType': ReCase(className).camelCase,
      'returnType': returnType,
      'members': members.map((e) => e.toMap()),
    };
    return map;
  }
}

class TdMember {
  String type;
  String name;
  bool isPrimitive;
  bool isVector = false;
  bool isVectorVector = false;
  bool get isContainer => isVector || isVectorVector;
  String subName = '';
  TdMember({
    required this.type,
    required this.name,
    required this.isPrimitive,
    this.isVector = false,
    this.isVectorVector = false,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'isPrimitive': isPrimitive,
      'isVectorVector': isVectorVector,
      'isVector': isVector,
      'isContainer': isContainer,
      'subName': subName,
    };
  }
}
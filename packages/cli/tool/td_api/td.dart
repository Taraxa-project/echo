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
  String get apiObjectPath => path.joinAll([tdApiPath, 'api', 'object']);
  String get apiFunctionPath => path.joinAll([tdApiPath, 'api', 'function']);

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
    _addTypeToFile(tlObject, apiObjectPath);
    var tdFile = _tdFiles.putIfAbsent(
        tlObject.superClassName,
        () => TdFile(
              typeName: tlObject.superClassName,
              dirPath: apiObjectPath,
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
    _addTypeToFile(tlFunction, apiObjectPath);
    var tdFile = _tdFiles.putIfAbsent(
        tlFunction.className,
        () => TdFile(
              typeName: tlFunction.className,
              dirPath: apiFunctionPath,
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
    await writeApi();
    await writeBase();
  }

  Future<void> createDirectories() async {
    await Directory(apiPath).create(recursive: true);
    await Directory(apiObjectPath).create(recursive: true);
    await Directory(apiFunctionPath).create(recursive: true);
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

  Future<void> writeBase() async {
    await File(basePath).writeAsString(
        Template(TdFile.baseTemplate, htmlEscapeValues: false)
            .renderString({}));
  }
}

class TdFile {
  String package;
  String dirPath;
  String packageFilePath;
  String typeName;
  Map<String, String> imports = {};
  Map<String, Td> classes = {};
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
      td.members.add(TdMember(type: tlParam.type.tdName, name: tlParam.name));
      if (!tlParam.type.isPrimitive &&
          !TlPrimitives.primitives.contains(tlParam.type.tdSubName)) {
        if (this.typeName != tlParam.type.tdSubName) {
          imports[tlParam.type.tdSubName] = tlParam.type.tdSubName;
        }
      }
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'package': {'value': package},
      'imports': imports.values.map((e) => {
            'value':
                "import 'package:/$package/api/object/${ReCase(e).snakeCase}.dart';",
          }),
      'classes': classes.values.map((td) => td.toMap()),
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

  {{! fromMap constructor}}
  {{ className }}.fromMap(Map<String, dynamic> map) {

  }

  {{! toMap}}
  Map<String, dynamic> toMap({skipNulls: true}) {
    return {};
  }

}
{{/ isAbstract }}
{{/ classes }}
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
  TdMember({required this.type, required this.name});
  Map<String, String> toMap() {
    return {
      'name': name,
      'type': type,
    };
  }
}

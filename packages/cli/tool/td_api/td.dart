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
  String get exportPath => path.joinAll([tdApiPath, '$package.dart']);
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
      var td = Td(
        className: tlObject.superClassName,
        superClassName: 'TdObject',
        isAbstract: true,
        comments: [],
      );
      if (tlObject.comment.abstractClassComment != null) {
        td.comments.add(tlObject.comment.abstractClassComment!.text);
      }
      tdFile.classes.putIfAbsent(tlObject.superClassName, () => td);
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
    await writeExport();
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

  Future<void> writeExport() async {
    await File(exportPath).writeAsString(Template(
      TdFile.exportTemplate,
      htmlEscapeValues: false,
    ).renderString({
      'files': _typeToFile.values.toSet().toList().map((e) => {
            'value': e,
          }),
    }));
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
              comments: [tlDefinition.comment.classComment.text],
            ));
    for (var comment in tlDefinition.comment.classComment.nextLines) {
      td.comments.add(comment.text);
    }
    tlDefinition.constructor.params.forEach((tlParam) {
      var tdMember = TdMember(
        type: tlParam.type.tdName,
        name: tlParam.name,
        isPrimitive: true,
        isVector: tlParam.type.isVector,
        isVectorVector: tlParam.type.isVectorVector,
        comments: [],
      );
      for (var comment in tlDefinition.comment.paramComments) {
        if (comment.paramName == tlParam.name) {
          tdMember.comments.add(comment.text);
          for (var nextLine in comment.nextLines) {
            tdMember.comments.add(nextLine.text);
          }
        }
      }
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

/// Aliases for TL base types to Dart types.
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

/// The base class for Telegram API objects and functions.
abstract class Td {
  /// JSON object type; maps to the field @type.
  String get tdType;

  /// Matches requests with responses; maps to the field @extra.
  String? extra;

  /// TDLib client id; maps to the field @client_id.
  int? client_id;

  Td({this.extra, this.client_id});

  /// Create a [Td] instance from a [Map].
  Td.fromMap(Map<String, dynamic> map);

  /// Create a [Map] from a [Td] instance.
  Map<String, dynamic> toMap({skipNulls: true});

  /// Serialize a [Td] instance to a JSON string.
  /// If [skipNulls] is [true] the fields with null values are not serialized.
  String toJson({skipNulls = true}) {
    return jsonEncode(toMap(skipNulls: skipNulls));
  }

  String toString({skipNulls = false}) {
    return toJson(skipNulls: skipNulls);
  }
}

/// The base class for Telegram API objects.
abstract class TdObject extends Td {
  TdObject({super.extra, super.client_id});
}

/// The base class for Telegram API functions.
abstract class TdFunction extends Td {
  /// The return type as String for this function.
  /// Currently not used.
  String get tdReturnType;
  
  TdFunction({super.extra, super.client_id});
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
{{# comments}}
/// {{ text }}
{{/ comments}}
abstract class {{ className }} extends {{ extendsClassName }} {
  {{ className }}({super.extra, super.client_id});
}
{{/ isAbstract }}

{{^ isAbstract}}
{{# comments}}
/// {{ text }}
{{/ comments}}
class {{ className }} extends {{ extendsClassName }} {
  {{! properties }}
  String get tdType => '{{ tdType }}';
  {{# isFunction }}
  String get tdReturnType => '{{ returnType }}';
  {{/ isFunction }}

  {{! class members }}
  {{# members }}

  {{# comments }}
  /// {{ text }}
  {{/ comments }}
  {{ type }}? {{ name }};
  {{/ members }}

  {{! default constructor }}
  {{ className }}({
    super.extra,
    super.client_id,
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
    if (map['{{ name }}'] != null) {
      {{ name }} = [];
      {{# isVector }}
      for (var someValue in map['{{ name }}']) {
        {{#isPrimitive}}
        {{ name }}?.add(someValue);
        {{/isPrimitive}}
        {{^isPrimitive}}
        if (someValue != null) {
          {{ name }}?.add(TdApiMap.fromMap(someValue) as {{ subName }});
        }
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
          if (someValue != null) {
            objs.add(TdApiMap.fromMap(someValue) as {{ subName }});
          }
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
    if (map['{{ name }}'] != null) {
      {{ name }} = TdApiMap.fromMap(map['{{ name }}']) as {{ subName }};
    }
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

/// Telegram API map from [String]s to [Td] objects.
class TdApiMap {
  /// Map from TL type (the field @type) to [Td] object.
  static Map<String, dynamic Function(Map<String, dynamic>)> _tdMap = {
    {{# map }}
    '{{ name }}': (map) => {{ type }}.fromMap(map),
    {{/ map }}
  };

  /// Create a [Td] instance from a JSON [String].
  static Td? fromMap(Map<String, dynamic> map) {
    return _tdMap.containsKey(map['@type']) ? _tdMap[map['@type']]!(map) : null;
  }
}
''';

  static String get exportTemplate => '''
export 'client.dart';

export 'api/base.dart';
export 'api/map.dart';

{{# files }}
export 'api/{{ value }}.dart';
{{/ files }}
''';
}

class Td {
  String className;
  String superClassName;
  bool isAbstract;
  bool isFunction;
  String returnType;
  List<TdMember> members = [];
  List<String> comments;

  Td({
    required this.className,
    required this.superClassName,
    this.isAbstract = false,
    this.isFunction = false,
    this.returnType = '',
    this.members = const [],
    this.comments = const [],
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
      'comments': comments.map((e) => {'text': e})
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
  List<String> comments;
  TdMember({
    required this.type,
    required this.name,
    required this.isPrimitive,
    this.isVector = false,
    this.isVectorVector = false,
    this.comments = const [],
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
      'comments': comments.map((e) => {'text': e})
    };
  }
}

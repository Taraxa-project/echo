import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';

import 'tl.dart';

class Td {
  String className;
  List<String> imports = [];
  List<TdMember> members = [];
  Td({required this.className});
  String get fileName => ReCase(className).snakeCase;
}

class TdAbstract extends Td {
  List<TdObject> tdObjects = [];
  TdAbstract({required super.className});

  dynamic toMap() {
    return {
      'className': className,
    };
  }
}

class TdObject extends Td {
  TdObject({required super.className});
}

class TdFunction extends Td {
  String returnType;
  TdFunction({required super.className, required this.returnType});
}

class TdMember {
  String name;
  String type;
  TdMember({
    required this.name,
    required this.type,
  });
}

class Api {
  String tdApiPath;
  String package;

  Map<String, Td> _tdObjects = {};
  List<Td> _tdFunctions = [];
  Map<String, String> _map = {};

  Api({
    required this.tdApiPath,
    required this.package,
  });

  ParseType _parseType = ParseType.object;

  void addTls(List<Tl> tls) {
    tls.forEach((tl) {
      if (tl is TlSwitch) {
        _parseType = ParseType.function;
      } else {
        var tlDefinition = (tl as TlDefinition);
        _parseType == ParseType.object
            ? addObjectDefinition(tlDefinition)
            : addFunctionDefinition(tlDefinition);
      }
    });
  }

  void addObjectDefinition(TlDefinition tlDefinition) {
    var tlConstructor = tlDefinition.constructor;

    var tdObject = TdObject(className: tlConstructor.className);

    if (tlConstructor.isLeafClass) {
      _tdObjects[tlConstructor.className] = tdObject;
    } else {
      var tdAbstract = (_tdObjects.putIfAbsent(tlConstructor.superClassName,
              () => TdAbstract(className: tlConstructor.superClassName))
          as TdAbstract);

      for (var tlParam in tlConstructor.params) {
        if (!tlParam.type.isPrimitive &&
            !tdAbstract.imports.contains(tlParam.type.tdName)) {
          tdAbstract.imports.add(tlParam.type.tdName);
        }
      }

      tdAbstract.tdObjects.add(tdObject);
    }

    for (var tlParam in tlConstructor.params) {
      tdObject.members.add(TdMember(
        name: tlParam.name,
        type: tlParam.type.tdName,
      ));
    }

    if (tlConstructor.isLeafClass) {
      for (var tlParam in tlConstructor.params) {
        if (!tlParam.type.isPrimitive &&
            !tdObject.imports.contains(tlParam.type.tdName)) {
          tdObject.imports.add(tlParam.type.tdName);
        }
      }
    }

    _map[tlConstructor.name] = tlConstructor.className;
  }

  void addFunctionDefinition(TlDefinition tlDefinition) {
    var tlConstructor = tlDefinition.constructor;

    var tdFunction = TdFunction(
      className: tlConstructor.className,
      returnType: tlConstructor.returnType.name,
    );

    tdFunction.imports.add(tlConstructor.returnType.name);

    for (var tlParam in tlConstructor.params) {
      tdFunction.members.add(TdMember(
        name: tlParam.name,
        type: tlParam.type.tdName,
      ));
      if (!tlParam.type.isPrimitive &&
          !tdFunction.imports.contains(tlParam.type.tdName)) {
        tdFunction.imports.add(tlParam.type.tdName);
      }
    }
    _tdFunctions.add(tdFunction);
    _map[tlConstructor.name] = tlConstructor.className;
  }

  String get apiPath => path.joinAll([tdApiPath, 'api']);
  String get apiObjectPath => path.joinAll([tdApiPath, 'api', 'object']);
  String get apiFunctionPath => path.joinAll([tdApiPath, 'api', 'function']);

  Future<void> writeFiles() async {
    await writeBase();
    await writeObjects();
    await writeFunctions();
  }

  Future<void> writeBase() async {}
  Future<void> writeObjects() async {}
  Future<void> writeFunctions() async {}
}

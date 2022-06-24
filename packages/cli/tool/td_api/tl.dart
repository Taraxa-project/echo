import 'package:recase/recase.dart';

enum ParseType { object, function }

class Tl {}

class TlSwitch extends Tl {}

class TlComment extends Tl {
  String text;

  TlComment({
    required this.text,
  });
}

class TlType extends Tl {
  String name;

  TlType({
    required this.name,
  });

  String get tdName => isPrimitive ? name : ReCase(name).pascalCase;
  bool get isPrimitive =>
      TlPrimitives.primitives.contains(name) || isVector || isVectorVector;
  bool get isVector => this.name.indexOf('vector<') > 0;
  bool get isVectorVector => this.name.indexOf('vector<vector<') > 0;
}

class TlParam extends Tl {
  String name;
  TlType type;

  TlParam({
    required this.name,
    required this.type,
  });
}

class TlConstructor extends Tl {
  String name;
  List<TlParam> params;
  TlType returnType;

  TlConstructor({
    required this.name,
    required this.params,
    required this.returnType,
  });

  String get className => ReCase(name).pascalCase;
  String get superClassName => returnType.name;
  bool get isLeafClass => className == superClassName;
}

class TlDefinition extends Tl {
  List<TlComment> comments;
  TlConstructor constructor;
  TlDefinition({this.comments = const [], required this.constructor});
}

class TlPrimitives {
  static get primitives => [
        'double',
        'string',
        'int32',
        'int53',
        'int64',
        'bytes',
        'Bool',
        'String'
      ];
}

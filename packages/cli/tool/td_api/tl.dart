import 'package:recase/recase.dart';

enum ParseType { object, function }

class Tl {}

class TlObject extends TlDefinition {
  TlObject({super.comments = const [], required super.constructor});
}

class TlFunction extends TlDefinition {
  TlFunction({
    super.comments = const [],
    required super.constructor,
  });
  bool get isLeafClass => true;
  String get fileName => ReCase(constructor.name).snakeCase;
  bool get extendsBase => true;
  String get extendsClasName => 'TdFunction';
  bool get isFunction => true;
}

class TlDefinition extends Tl {
  List<TlCommentValue> comments;
  TlConstructor constructor;
  TlDefinition({
    this.comments = const [],
    required this.constructor,
  });
  String get className => ReCase(constructor.name).pascalCase;
  String get superClassName => constructor.returnType.name;
  String get fileName => ReCase(constructor.returnType.name).snakeCase;
  bool get extendsBase => className == superClassName;
  String get extendsClasName => extendsBase ? 'TdObject' : superClassName;
  String get returnType => constructor.returnType.name;
  bool get isFunction => false;
}

class TlCommentValue extends Tl {
  String text;
  TlCommentValue({
    required this.text,
  });
}

class TlAbstractClassComment extends TlCommentValue {
  TlAbstractClassComment({required super.text});
}

class TlClassComment extends TlCommentValue {
  TlClassComment({required super.text});
}

class TlParamComment extends TlCommentValue {
  String paramName;
  TlParamComment({required super.text, required this.paramName});
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
}

class TlType extends Tl {
  String name;
  TlType({
    required this.name,
  });
  String get tdName => isPrimitive ? name : _getTdName();
  bool get isPrimitive => TlPrimitives.primitives.contains(name);
  bool get isVector => this.name.indexOf('vector<') != -1 && !isVectorVector;
  bool get isVectorVector => this.name.indexOf('vector<vector<') != -1;
  bool get isContainer => isVector || isVectorVector;
  String get tdSubName => _getTdSubName();

  String _getTdName() {
    var subName = _getTdSubName();
    if (isVector || isVectorVector) {
      return name.replaceRange(this.name.lastIndexOf('<') + 1,
          this.name.indexOf('>'), _getTdSubName());
    } else {
      return subName;
    }
  }

  String _getTdSubName() {
    var subName = name;
    if (isVector || isVectorVector) {
      subName = this
          .name
          .substring(this.name.lastIndexOf('<') + 1, this.name.indexOf('>'));
    }

    if (TlPrimitives.primitives.contains(subName)) {
      return subName;
    } else {
      return ReCase(subName).pascalCase;
    }
  }
}

class TlParam extends Tl {
  String name;
  TlType type;
  TlParam({
    required this.name,
    required this.type,
  });
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

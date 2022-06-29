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
  List toMap({skipNulls: true}) => this.map((e) => e.ToMap()).toList();
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

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
  // List toMap({skipNulls: true}) =>
  //     this.map((e) => e.toMap(skipNulls: skipNulls)).toList();
}

abstract class Td {
  // JSON object type; maps to the field @type
  String get tdType;

  // Matches requests with responses; maps to the field @extra
  String? extra;

  // tdlib client id; maps to the field @client_id
  int? client_id;

  Td({this.extra, this.client_id});
  Td.fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap({skipNulls: true});

  String toJson({skipNulls = true}) {
    return jsonEncode(toMap(skipNulls: skipNulls));
  }

  String toString({skipNulls = false}) {
    return toJson(skipNulls: skipNulls);
  }
}

abstract class TdObject extends Td {
  TdObject({super.extra, super.client_id});
}

abstract class TdFunction extends Td {
  String get tdReturnType;
  TdFunction({super.extra, super.client_id});
}

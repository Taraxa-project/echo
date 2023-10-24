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
  bool toMap({skipNulls = true}) => this;
}

extension IntMap on int {
  int toMap({skipNulls = true}) => this;
}

extension DoubleMap on double {
  double toMap({skipNulls = true}) => this;
}

extension StringMap on String {
  String toMap({skipNulls = true}) => this;
}

extension ListMap on List {
  List toMap({skipNulls = true}) => this;
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
  Map<String, dynamic> toMap({skipNulls = true});

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

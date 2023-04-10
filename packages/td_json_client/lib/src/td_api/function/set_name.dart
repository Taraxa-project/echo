import 'package:td_json_client/src/td_api/td.dart';

/// Changes the first and last name of the current user
class SetName extends TdFunction {
  String get tdType => 'setName';
  String get tdReturnType => 'Ok';

  /// The new value of the first name for the current user; 1-64 characters
  string? first_name;

  /// The new value of the optional last name for the current user; 0-64 characters
  string? last_name;

  SetName({
    super.extra,
    super.client_id,
    this.first_name,
    this.last_name,
  });

  SetName.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    first_name = map['first_name'];
    last_name = map['last_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'first_name': first_name?.toMap(skipNulls: skipNulls),
      'last_name': last_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

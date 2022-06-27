import 'package:td_json_client/api/base.dart';

class SetName extends TdFunction {
  String get tdType => 'setName';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? first_name;
  string? last_name;

  SetName({
    this.extra,
    this.client_id,
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

import 'package:td_json_client/api/base.dart';

class GetOption extends TdFunction {
  String get tdType => 'getOption';
  String get tdReturnType => 'OptionValue';

  string? extra;
  int? client_id;
  string? name;

  GetOption({
    this.extra,
    this.client_id,
    this.name,
  });

  GetOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

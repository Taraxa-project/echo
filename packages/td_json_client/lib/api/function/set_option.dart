import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/option_value.dart';

class SetOption extends TdFunction {
  String get tdType => 'setOption';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? name;
  OptionValue? value;

  SetOption({
    this.extra,
    this.client_id,
    this.name,
    this.value,
  });

  SetOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    value = TdApiMap.fromMap(map['value']) as OptionValue;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

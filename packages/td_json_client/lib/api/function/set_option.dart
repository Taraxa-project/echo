import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/option_value.dart';


/// Sets the value of an option. (Check the list of available options on https://core.telegram.org/tdlib/options.) Only writable options can be set. Can be called before authorization
class SetOption extends TdFunction {
  String get tdType => 'setOption';
  String get tdReturnType => 'Ok';


  /// The name of the option
  string? name;

  /// The new value of the option; pass null to reset option value to a default value
  OptionValue? value;

  SetOption({
    super.extra,
    super.client_id,
    this.name,
    this.value,
  });

  SetOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    if (map['value'] != null) {
      value = TdApiMap.fromMap(map['value']) as OptionValue;
    }
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

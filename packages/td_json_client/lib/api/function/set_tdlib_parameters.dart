import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/tdlib_parameters.dart';

class SetTdlibParameters extends TdFunction {
  String get tdType => 'setTdlibParameters';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  TdlibParameters? parameters;

  SetTdlibParameters({
    this.extra,
    this.client_id,
    this.parameters,
  });

  SetTdlibParameters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    parameters = TdApiMap.fromMap(map['parameters']) as TdlibParameters;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'parameters': parameters?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

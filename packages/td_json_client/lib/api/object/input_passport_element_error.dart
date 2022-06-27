import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';
import 'package:td_json_client/api/object/input_passport_element_error_source.dart';

class InputPassportElementError extends TdObject {
  String get tdType => 'inputPassportElementError';

  string? extra;
  int? client_id;
  PassportElementType? type;
  string? message;
  InputPassportElementErrorSource? source;

  InputPassportElementError({
    this.extra,
    this.client_id,
    this.type,
    this.message,
    this.source,
  });

  InputPassportElementError.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = TdApiMap.fromMap(map['type']) as PassportElementType;
    message = map['message'];
    source = TdApiMap.fromMap(map['source']) as InputPassportElementErrorSource;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'source': source?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

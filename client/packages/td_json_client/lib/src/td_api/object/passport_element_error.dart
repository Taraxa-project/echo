import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/passport_element_type.dart';
import 'package:td_json_client/src/td_api/object/passport_element_error_source.dart';

/// Contains the description of an error in a Telegram Passport element
class PassportElementError extends TdObject {
  String get tdType => 'passportElementError';

  /// Type of the Telegram Passport element which has the error
  PassportElementType? type;

  /// Error message
  string? message;

  /// Error source
  PassportElementErrorSource? source;

  PassportElementError({
    super.extra,
    super.client_id,
    this.type,
    this.message,
    this.source,
  });

  PassportElementError.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as PassportElementType;
    }
    message = map['message'];
    if (map['source'] != null) {
      source = TdApiMap.fromMap(map['source']) as PassportElementErrorSource;
    }
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

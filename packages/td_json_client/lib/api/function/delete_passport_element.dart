import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';


/// Deletes a Telegram Passport element 
class DeletePassportElement extends TdFunction {
  String get tdType => 'deletePassportElement';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Element type
  PassportElementType? type;

  DeletePassportElement({
    this.extra,
    this.client_id,
    this.type,
  });

  DeletePassportElement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = TdApiMap.fromMap(map['type']) as PassportElementType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

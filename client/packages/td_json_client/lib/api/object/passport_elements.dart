import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element.dart';


/// Contains information about saved Telegram Passport elements 
class PassportElements extends TdObject {
  String get tdType => 'passportElements';


  /// Telegram Passport elements
  vector<PassportElement>? elements;

  PassportElements({
    super.extra,
    super.client_id,
    this.elements,
  });

  PassportElements.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['elements'] != null) {
      elements = [];
      for (var someValue in map['elements']) {
        if (someValue != null) {
          elements?.add(TdApiMap.fromMap(someValue) as PassportElement);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'elements': elements?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
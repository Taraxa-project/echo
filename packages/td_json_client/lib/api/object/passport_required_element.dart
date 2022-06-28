import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_suitable_element.dart';


/// Contains a description of the required Telegram Passport element that was requested by a service 
class PassportRequiredElement extends TdObject {
  String get tdType => 'passportRequiredElement';

  String? extra;
  int? client_id;

  /// List of Telegram Passport elements any of which is enough to provide
  vector<PassportSuitableElement>? suitable_elements;

  PassportRequiredElement({
    this.extra,
    this.client_id,
    this.suitable_elements,
  });

  PassportRequiredElement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['suitable_elements']) {
      suitable_elements = [];
      for (var someValue in map['suitable_elements']) {
        suitable_elements?.add(TdApiMap.fromMap(someValue) as PassportSuitableElement);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'suitable_elements': suitable_elements?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

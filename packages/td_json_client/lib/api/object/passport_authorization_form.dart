import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_required_element.dart';

class PassportAuthorizationForm extends TdObject {
  String get tdType => 'passportAuthorizationForm';

  String? extra;
  int? client_id;
  int32? id;
  vector<PassportRequiredElement>? required_elements;
  string? privacy_policy_url;

  PassportAuthorizationForm({
    this.extra,
    this.client_id,
    this.id,
    this.required_elements,
    this.privacy_policy_url,
  });

  PassportAuthorizationForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['required_elements']) {
      required_elements = [];
      for (var someValue in map['required_elements']) {
        required_elements?.add(TdApiMap.fromMap(someValue) as PassportRequiredElement);
      }
    }
    privacy_policy_url = map['privacy_policy_url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'required_elements': required_elements?.toMap(skipNulls: skipNulls),
      'privacy_policy_url': privacy_policy_url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

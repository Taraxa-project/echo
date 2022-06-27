import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';

class TermsOfService extends TdObject {
  String get tdType => 'termsOfService';

  string? extra;
  int? client_id;
  FormattedText? text;
  int32? min_user_age;
  Bool? show_popup;

  TermsOfService({
    this.extra,
    this.client_id,
    this.text,
    this.min_user_age,
    this.show_popup,
  });

  TermsOfService.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = TdApiMap.fromMap(map['text']) as FormattedText;
    min_user_age = map['min_user_age'];
    show_popup = map['show_popup'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'min_user_age': min_user_age?.toMap(skipNulls: skipNulls),
      'show_popup': show_popup?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

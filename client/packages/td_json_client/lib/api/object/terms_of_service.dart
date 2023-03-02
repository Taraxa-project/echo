import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';


/// Contains Telegram terms of service 
class TermsOfService extends TdObject {
  String get tdType => 'termsOfService';


  /// Text of the terms of service 
  FormattedText? text;

  /// The minimum age of a user to be able to accept the terms; 0 if age isn't restricted 
  int32? min_user_age;

  /// True, if a blocking popup with terms of service must be shown to the user
  Bool? show_popup;

  TermsOfService({
    super.extra,
    super.client_id,
    this.text,
    this.min_user_age,
    this.show_popup,
  });

  TermsOfService.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as FormattedText;
    }
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

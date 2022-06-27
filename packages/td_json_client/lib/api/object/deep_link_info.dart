import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';

class DeepLinkInfo extends TdObject {
  String get tdType => 'deepLinkInfo';

  string? extra;
  int? client_id;
  FormattedText? text;
  Bool? need_update_application;

  DeepLinkInfo({
    this.extra,
    this.client_id,
    this.text,
    this.need_update_application,
  });

  DeepLinkInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = TdApiMap.fromMap(map['text']) as FormattedText;
    need_update_application = map['need_update_application'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'need_update_application': need_update_application?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
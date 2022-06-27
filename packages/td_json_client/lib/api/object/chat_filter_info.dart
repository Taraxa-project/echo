import 'package:td_json_client/api/base.dart';

class ChatFilterInfo extends TdObject {
  String get tdType => 'chatFilterInfo';

  String? extra;
  int? client_id;
  int32? id;
  string? title;
  string? icon_name;

  ChatFilterInfo({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.icon_name,
  });

  ChatFilterInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    icon_name = map['icon_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'icon_name': icon_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

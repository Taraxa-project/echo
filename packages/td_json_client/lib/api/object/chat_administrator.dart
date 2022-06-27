import 'package:td_json_client/api/base.dart';

class ChatAdministrator extends TdObject {
  String get tdType => 'chatAdministrator';

  string? extra;
  int? client_id;
  int53? user_id;
  string? custom_title;
  Bool? is_owner;

  ChatAdministrator({
    this.extra,
    this.client_id,
    this.user_id,
    this.custom_title,
    this.is_owner,
  });

  ChatAdministrator.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    custom_title = map['custom_title'];
    is_owner = map['is_owner'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'custom_title': custom_title?.toMap(skipNulls: skipNulls),
      'is_owner': is_owner?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

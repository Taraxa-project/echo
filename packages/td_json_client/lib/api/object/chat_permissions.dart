import 'package:td_json_client/api/base.dart';

class ChatPermissions extends TdObject {
  String get tdType => 'chatPermissions';

  String? extra;
  int? client_id;
  Bool? can_send_messages;
  Bool? can_send_media_messages;
  Bool? can_send_polls;
  Bool? can_send_other_messages;
  Bool? can_add_web_page_previews;
  Bool? can_change_info;
  Bool? can_invite_users;
  Bool? can_pin_messages;

  ChatPermissions({
    this.extra,
    this.client_id,
    this.can_send_messages,
    this.can_send_media_messages,
    this.can_send_polls,
    this.can_send_other_messages,
    this.can_add_web_page_previews,
    this.can_change_info,
    this.can_invite_users,
    this.can_pin_messages,
  });

  ChatPermissions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    can_send_messages = map['can_send_messages'];
    can_send_media_messages = map['can_send_media_messages'];
    can_send_polls = map['can_send_polls'];
    can_send_other_messages = map['can_send_other_messages'];
    can_add_web_page_previews = map['can_add_web_page_previews'];
    can_change_info = map['can_change_info'];
    can_invite_users = map['can_invite_users'];
    can_pin_messages = map['can_pin_messages'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'can_send_messages': can_send_messages?.toMap(skipNulls: skipNulls),
      'can_send_media_messages': can_send_media_messages?.toMap(skipNulls: skipNulls),
      'can_send_polls': can_send_polls?.toMap(skipNulls: skipNulls),
      'can_send_other_messages': can_send_other_messages?.toMap(skipNulls: skipNulls),
      'can_add_web_page_previews': can_add_web_page_previews?.toMap(skipNulls: skipNulls),
      'can_change_info': can_change_info?.toMap(skipNulls: skipNulls),
      'can_invite_users': can_invite_users?.toMap(skipNulls: skipNulls),
      'can_pin_messages': can_pin_messages?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

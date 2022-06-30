import 'package:td_json_client/api/base.dart';


/// Describes actions that a user is allowed to take in a chat
class ChatPermissions extends TdObject {
  String get tdType => 'chatPermissions';


  /// True, if the user can send text messages, contacts, locations, and venues
  Bool? can_send_messages;

  /// True, if the user can send audio files, documents, photos, videos, video notes, and voice notes. Implies can_send_messages permissions
  Bool? can_send_media_messages;

  /// True, if the user can send polls. Implies can_send_messages permissions
  Bool? can_send_polls;

  /// True, if the user can send animations, games, stickers, and dice and use inline bots. Implies can_send_messages permissions
  Bool? can_send_other_messages;

  /// True, if the user may add a web page preview to their messages. Implies can_send_messages permissions
  Bool? can_add_web_page_previews;

  /// True, if the user can change the chat title, photo, and other settings
  Bool? can_change_info;

  /// True, if the user can invite new users to the chat
  Bool? can_invite_users;

  /// True, if the user can pin messages
  Bool? can_pin_messages;

  ChatPermissions({
    super.extra,
    super.client_id,
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

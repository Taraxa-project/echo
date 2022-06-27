import 'package:td_json_client/api/base.dart';

class ChatEventLogFilters extends TdObject {
  String get tdType => 'chatEventLogFilters';

  String? extra;
  int? client_id;
  Bool? message_edits;
  Bool? message_deletions;
  Bool? message_pins;
  Bool? member_joins;
  Bool? member_leaves;
  Bool? member_invites;
  Bool? member_promotions;
  Bool? member_restrictions;
  Bool? info_changes;
  Bool? setting_changes;
  Bool? invite_link_changes;
  Bool? video_chat_changes;

  ChatEventLogFilters({
    this.extra,
    this.client_id,
    this.message_edits,
    this.message_deletions,
    this.message_pins,
    this.member_joins,
    this.member_leaves,
    this.member_invites,
    this.member_promotions,
    this.member_restrictions,
    this.info_changes,
    this.setting_changes,
    this.invite_link_changes,
    this.video_chat_changes,
  });

  ChatEventLogFilters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_edits = map['message_edits'];
    message_deletions = map['message_deletions'];
    message_pins = map['message_pins'];
    member_joins = map['member_joins'];
    member_leaves = map['member_leaves'];
    member_invites = map['member_invites'];
    member_promotions = map['member_promotions'];
    member_restrictions = map['member_restrictions'];
    info_changes = map['info_changes'];
    setting_changes = map['setting_changes'];
    invite_link_changes = map['invite_link_changes'];
    video_chat_changes = map['video_chat_changes'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_edits': message_edits?.toMap(skipNulls: skipNulls),
      'message_deletions': message_deletions?.toMap(skipNulls: skipNulls),
      'message_pins': message_pins?.toMap(skipNulls: skipNulls),
      'member_joins': member_joins?.toMap(skipNulls: skipNulls),
      'member_leaves': member_leaves?.toMap(skipNulls: skipNulls),
      'member_invites': member_invites?.toMap(skipNulls: skipNulls),
      'member_promotions': member_promotions?.toMap(skipNulls: skipNulls),
      'member_restrictions': member_restrictions?.toMap(skipNulls: skipNulls),
      'info_changes': info_changes?.toMap(skipNulls: skipNulls),
      'setting_changes': setting_changes?.toMap(skipNulls: skipNulls),
      'invite_link_changes': invite_link_changes?.toMap(skipNulls: skipNulls),
      'video_chat_changes': video_chat_changes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

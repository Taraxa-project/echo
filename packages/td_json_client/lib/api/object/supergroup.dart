import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';

class Supergroup extends TdObject {
  String get tdType => 'supergroup';

  string? extra;
  int? client_id;
  int53? id;
  string? username;
  int32? date;
  ChatMemberStatus? status;
  int32? member_count;
  Bool? has_linked_chat;
  Bool? has_location;
  Bool? sign_messages;
  Bool? is_slow_mode_enabled;
  Bool? is_channel;
  Bool? is_broadcast_group;
  Bool? is_verified;
  string? restriction_reason;
  Bool? is_scam;
  Bool? is_fake;

  Supergroup({
    this.extra,
    this.client_id,
    this.id,
    this.username,
    this.date,
    this.status,
    this.member_count,
    this.has_linked_chat,
    this.has_location,
    this.sign_messages,
    this.is_slow_mode_enabled,
    this.is_channel,
    this.is_broadcast_group,
    this.is_verified,
    this.restriction_reason,
    this.is_scam,
    this.is_fake,
  });

  Supergroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    username = map['username'];
    date = map['date'];
    status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
    member_count = map['member_count'];
    has_linked_chat = map['has_linked_chat'];
    has_location = map['has_location'];
    sign_messages = map['sign_messages'];
    is_slow_mode_enabled = map['is_slow_mode_enabled'];
    is_channel = map['is_channel'];
    is_broadcast_group = map['is_broadcast_group'];
    is_verified = map['is_verified'];
    restriction_reason = map['restriction_reason'];
    is_scam = map['is_scam'];
    is_fake = map['is_fake'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'status': status?.toMap(skipNulls: skipNulls),
      'member_count': member_count?.toMap(skipNulls: skipNulls),
      'has_linked_chat': has_linked_chat?.toMap(skipNulls: skipNulls),
      'has_location': has_location?.toMap(skipNulls: skipNulls),
      'sign_messages': sign_messages?.toMap(skipNulls: skipNulls),
      'is_slow_mode_enabled': is_slow_mode_enabled?.toMap(skipNulls: skipNulls),
      'is_channel': is_channel?.toMap(skipNulls: skipNulls),
      'is_broadcast_group': is_broadcast_group?.toMap(skipNulls: skipNulls),
      'is_verified': is_verified?.toMap(skipNulls: skipNulls),
      'restriction_reason': restriction_reason?.toMap(skipNulls: skipNulls),
      'is_scam': is_scam?.toMap(skipNulls: skipNulls),
      'is_fake': is_fake?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

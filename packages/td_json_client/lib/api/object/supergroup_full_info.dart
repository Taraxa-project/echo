import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/chat_location.dart';
import 'package:td_json_client/api/object/chat_invite_link.dart';
import 'package:td_json_client/api/object/bot_commands.dart';

class SupergroupFullInfo extends TdObject {
  String get tdType => 'supergroupFullInfo';

  String? extra;
  int? client_id;
  ChatPhoto? photo;
  string? description;
  int32? member_count;
  int32? administrator_count;
  int32? restricted_count;
  int32? banned_count;
  int53? linked_chat_id;
  int32? slow_mode_delay;
  double? slow_mode_delay_expires_in;
  Bool? can_get_members;
  Bool? can_set_username;
  Bool? can_set_sticker_set;
  Bool? can_set_location;
  Bool? can_get_statistics;
  Bool? is_all_history_available;
  int64? sticker_set_id;
  ChatLocation? location;
  ChatInviteLink? invite_link;
  vector<BotCommands>? bot_commands;
  int53? upgraded_from_basic_group_id;
  int53? upgraded_from_max_message_id;

  SupergroupFullInfo({
    this.extra,
    this.client_id,
    this.photo,
    this.description,
    this.member_count,
    this.administrator_count,
    this.restricted_count,
    this.banned_count,
    this.linked_chat_id,
    this.slow_mode_delay,
    this.slow_mode_delay_expires_in,
    this.can_get_members,
    this.can_set_username,
    this.can_set_sticker_set,
    this.can_set_location,
    this.can_get_statistics,
    this.is_all_history_available,
    this.sticker_set_id,
    this.location,
    this.invite_link,
    this.bot_commands,
    this.upgraded_from_basic_group_id,
    this.upgraded_from_max_message_id,
  });

  SupergroupFullInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
    description = map['description'];
    member_count = map['member_count'];
    administrator_count = map['administrator_count'];
    restricted_count = map['restricted_count'];
    banned_count = map['banned_count'];
    linked_chat_id = map['linked_chat_id'];
    slow_mode_delay = map['slow_mode_delay'];
    slow_mode_delay_expires_in = map['slow_mode_delay_expires_in'];
    can_get_members = map['can_get_members'];
    can_set_username = map['can_set_username'];
    can_set_sticker_set = map['can_set_sticker_set'];
    can_set_location = map['can_set_location'];
    can_get_statistics = map['can_get_statistics'];
    is_all_history_available = map['is_all_history_available'];
    sticker_set_id = map['sticker_set_id'];
    location = TdApiMap.fromMap(map['location']) as ChatLocation;
    invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    if (map['bot_commands']) {
      bot_commands = [];
      for (var someValue in map['bot_commands']) {
        bot_commands?.add(TdApiMap.fromMap(someValue) as BotCommands);
      }
    }
    upgraded_from_basic_group_id = map['upgraded_from_basic_group_id'];
    upgraded_from_max_message_id = map['upgraded_from_max_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'member_count': member_count?.toMap(skipNulls: skipNulls),
      'administrator_count': administrator_count?.toMap(skipNulls: skipNulls),
      'restricted_count': restricted_count?.toMap(skipNulls: skipNulls),
      'banned_count': banned_count?.toMap(skipNulls: skipNulls),
      'linked_chat_id': linked_chat_id?.toMap(skipNulls: skipNulls),
      'slow_mode_delay': slow_mode_delay?.toMap(skipNulls: skipNulls),
      'slow_mode_delay_expires_in': slow_mode_delay_expires_in?.toMap(skipNulls: skipNulls),
      'can_get_members': can_get_members?.toMap(skipNulls: skipNulls),
      'can_set_username': can_set_username?.toMap(skipNulls: skipNulls),
      'can_set_sticker_set': can_set_sticker_set?.toMap(skipNulls: skipNulls),
      'can_set_location': can_set_location?.toMap(skipNulls: skipNulls),
      'can_get_statistics': can_get_statistics?.toMap(skipNulls: skipNulls),
      'is_all_history_available': is_all_history_available?.toMap(skipNulls: skipNulls),
      'sticker_set_id': sticker_set_id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'bot_commands': bot_commands?.toMap(skipNulls: skipNulls),
      'upgraded_from_basic_group_id': upgraded_from_basic_group_id?.toMap(skipNulls: skipNulls),
      'upgraded_from_max_message_id': upgraded_from_max_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_photo.dart';
import 'package:td_json_client/src/td_api/object/chat_location.dart';
import 'package:td_json_client/src/td_api/object/chat_invite_link.dart';
import 'package:td_json_client/src/td_api/object/bot_commands.dart';

/// Contains full information about a supergroup or channel
class SupergroupFullInfo extends TdObject {
  String get tdType => 'supergroupFullInfo';

  /// Chat photo; may be null if empty or unknown. If non-null, then it is the same photo as in chat.photo
  ChatPhoto? photo;

  string? description;

  /// Number of members in the supergroup or channel; 0 if unknown
  int32? member_count;

  /// Number of privileged users in the supergroup or channel; 0 if unknown
  int32? administrator_count;

  /// Number of restricted users in the supergroup; 0 if unknown
  int32? restricted_count;

  /// Number of users banned from chat; 0 if unknown
  int32? banned_count;

  /// Chat identifier of a discussion group for the channel, or a channel, for which the supergroup is the designated discussion group; 0 if none or unknown
  int53? linked_chat_id;

  /// Delay between consecutive sent messages for non-administrator supergroup members, in seconds
  int32? slow_mode_delay;

  /// Time left before next message can be sent in the supergroup, in seconds. An updateSupergroupFullInfo update is not triggered when value of this field changes, but both new and old values are non-zero
  double? slow_mode_delay_expires_in;

  /// True, if members of the chat can be retrieved via getSupergroupMembers or searchChatMembers
  Bool? can_get_members;

  /// True, if non-administrators can receive only administrators and bots using getSupergroupMembers or searchChatMembers
  Bool? has_hidden_members;

  /// True, if non-administrators and non-bots can be hidden in responses to getSupergroupMembers and searchChatMembers for non-administrators
  Bool? can_hide_members;

  /// True, if the supergroup sticker set can be changed
  Bool? can_set_sticker_set;

  /// True, if the supergroup location can be changed
  Bool? can_set_location;

  /// True, if the supergroup or channel statistics are available
  Bool? can_get_statistics;

  /// True, if aggressive anti-spam checks can be enabled or disabled in the supergroup
  Bool? can_toggle_aggressive_anti_spam;

  /// True, if new chat members will have access to old messages. In public, discussion, of forum groups and all channels, old messages are always available,
  /// so this option affects only private non-forum supergroups without a linked chat. The value of this field is only available to chat administrators
  Bool? is_all_history_available;

  /// True, if aggressive anti-spam checks are enabled in the supergroup. The value of this field is only available to chat administrators
  Bool? has_aggressive_anti_spam_enabled;

  /// Identifier of the supergroup sticker set; 0 if none
  int64? sticker_set_id;

  /// Location to which the supergroup is connected; may be null
  ChatLocation? location;

  /// Primary invite link for the chat; may be null. For chat administrators with can_invite_users right only
  ChatInviteLink? invite_link;

  /// List of commands of bots in the group
  vector<BotCommands>? bot_commands;

  /// Identifier of the basic group from which supergroup was upgraded; 0 if none
  int53? upgraded_from_basic_group_id;

  /// Identifier of the last message in the basic group from which supergroup was upgraded; 0 if none
  int53? upgraded_from_max_message_id;

  SupergroupFullInfo({
    super.extra,
    super.client_id,
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
    this.has_hidden_members,
    this.can_hide_members,
    this.can_set_sticker_set,
    this.can_set_location,
    this.can_get_statistics,
    this.can_toggle_aggressive_anti_spam,
    this.is_all_history_available,
    this.has_aggressive_anti_spam_enabled,
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
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
    }
    description = map['description'];
    member_count = map['member_count'];
    administrator_count = map['administrator_count'];
    restricted_count = map['restricted_count'];
    banned_count = map['banned_count'];
    linked_chat_id = map['linked_chat_id'];
    slow_mode_delay = map['slow_mode_delay'];
    slow_mode_delay_expires_in = map['slow_mode_delay_expires_in'];
    can_get_members = map['can_get_members'];
    has_hidden_members = map['has_hidden_members'];
    can_hide_members = map['can_hide_members'];
    can_set_sticker_set = map['can_set_sticker_set'];
    can_set_location = map['can_set_location'];
    can_get_statistics = map['can_get_statistics'];
    can_toggle_aggressive_anti_spam = map['can_toggle_aggressive_anti_spam'];
    is_all_history_available = map['is_all_history_available'];
    has_aggressive_anti_spam_enabled = map['has_aggressive_anti_spam_enabled'];
    sticker_set_id = map['sticker_set_id'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as ChatLocation;
    }
    if (map['invite_link'] != null) {
      invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    }
    if (map['bot_commands'] != null) {
      bot_commands = [];
      for (var someValue in map['bot_commands']) {
        if (someValue != null) {
          bot_commands?.add(TdApiMap.fromMap(someValue) as BotCommands);
        }
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
      'has_hidden_members': has_hidden_members?.toMap(skipNulls: skipNulls),
      'can_hide_members': can_hide_members?.toMap(skipNulls: skipNulls),
      'can_set_sticker_set': can_set_sticker_set?.toMap(skipNulls: skipNulls),
      'can_set_location': can_set_location?.toMap(skipNulls: skipNulls),
      'can_get_statistics': can_get_statistics?.toMap(skipNulls: skipNulls),
      'can_toggle_aggressive_anti_spam': can_toggle_aggressive_anti_spam?.toMap(skipNulls: skipNulls),
      'is_all_history_available': is_all_history_available?.toMap(skipNulls: skipNulls),
      'has_aggressive_anti_spam_enabled': has_aggressive_anti_spam_enabled?.toMap(skipNulls: skipNulls),
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

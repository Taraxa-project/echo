import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/chat_member.dart';
import 'package:td_json_client/api/object/chat_invite_link.dart';
import 'package:td_json_client/api/object/bot_commands.dart';


/// Contains full information about a basic group
class BasicGroupFullInfo extends TdObject {
  String get tdType => 'basicGroupFullInfo';

  String? extra;
  int? client_id;

  /// Chat photo; may be null
  ChatPhoto? photo;

  string? description;

  /// User identifier of the creator of the group; 0 if unknown
  int53? creator_user_id;

  /// Group members
  vector<ChatMember>? members;

  /// Primary invite link for this group; may be null. For chat administrators with can_invite_users right only. Updated only after the basic group is opened
  ChatInviteLink? invite_link;

  /// List of commands of bots in the group
  vector<BotCommands>? bot_commands;

  BasicGroupFullInfo({
    this.extra,
    this.client_id,
    this.photo,
    this.description,
    this.creator_user_id,
    this.members,
    this.invite_link,
    this.bot_commands,
  });

  BasicGroupFullInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
    }
    description = map['description'];
    creator_user_id = map['creator_user_id'];
    if (map['members'] != null) {
      members = [];
      for (var someValue in map['members']) {
        if (someValue != null) {
          members?.add(TdApiMap.fromMap(someValue) as ChatMember);
        }
      }
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
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'creator_user_id': creator_user_id?.toMap(skipNulls: skipNulls),
      'members': members?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'bot_commands': bot_commands?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

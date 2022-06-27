import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/chat_member.dart';
import 'package:td_json_client/api/object/chat_invite_link.dart';
import 'package:td_json_client/api/object/bot_commands.dart';

class BasicGroupFullInfo extends TdObject {
  String get tdType => 'basicGroupFullInfo';

  String? extra;
  int? client_id;
  ChatPhoto? photo;
  string? description;
  int53? creator_user_id;
  vector<ChatMember>? members;
  ChatInviteLink? invite_link;
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
    photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
    description = map['description'];
    creator_user_id = map['creator_user_id'];
    if (map['members']) {
      members = [];
      for (var someValue in map['members']) {
        members?.add(TdApiMap.fromMap(someValue) as ChatMember);
      }
    }
    invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    if (map['bot_commands']) {
      bot_commands = [];
      for (var someValue in map['bot_commands']) {
        bot_commands?.add(TdApiMap.fromMap(someValue) as BotCommands);
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

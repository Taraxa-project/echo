import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/bot_command.dart';

class UserFullInfo extends TdObject {
  String get tdType => 'userFullInfo';

  string? extra;
  int? client_id;
  ChatPhoto? photo;
  Bool? is_blocked;
  Bool? can_be_called;
  Bool? supports_video_calls;
  Bool? has_private_calls;
  Bool? has_private_forwards;
  Bool? need_phone_number_privacy_exception;
  string? bio;
  string? share_text;
  string? description;
  int32? group_in_common_count;
  vector<BotCommand>? commands;

  UserFullInfo({
    this.extra,
    this.client_id,
    this.photo,
    this.is_blocked,
    this.can_be_called,
    this.supports_video_calls,
    this.has_private_calls,
    this.has_private_forwards,
    this.need_phone_number_privacy_exception,
    this.bio,
    this.share_text,
    this.description,
    this.group_in_common_count,
    this.commands,
  });

  UserFullInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
    is_blocked = map['is_blocked'];
    can_be_called = map['can_be_called'];
    supports_video_calls = map['supports_video_calls'];
    has_private_calls = map['has_private_calls'];
    has_private_forwards = map['has_private_forwards'];
    need_phone_number_privacy_exception = map['need_phone_number_privacy_exception'];
    bio = map['bio'];
    share_text = map['share_text'];
    description = map['description'];
    group_in_common_count = map['group_in_common_count'];
    if (map['commands']) {
      commands = [];
      for (var someValue in map['commands']) {
        commands?.add(TdApiMap.fromMap(someValue) as BotCommand);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'is_blocked': is_blocked?.toMap(skipNulls: skipNulls),
      'can_be_called': can_be_called?.toMap(skipNulls: skipNulls),
      'supports_video_calls': supports_video_calls?.toMap(skipNulls: skipNulls),
      'has_private_calls': has_private_calls?.toMap(skipNulls: skipNulls),
      'has_private_forwards': has_private_forwards?.toMap(skipNulls: skipNulls),
      'need_phone_number_privacy_exception': need_phone_number_privacy_exception?.toMap(skipNulls: skipNulls),
      'bio': bio?.toMap(skipNulls: skipNulls),
      'share_text': share_text?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'group_in_common_count': group_in_common_count?.toMap(skipNulls: skipNulls),
      'commands': commands?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

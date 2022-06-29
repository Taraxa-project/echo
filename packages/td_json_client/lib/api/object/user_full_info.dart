import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/bot_info.dart';


/// Contains full information about a user
class UserFullInfo extends TdObject {
  String get tdType => 'userFullInfo';

  String? extra;
  int? client_id;

  /// User profile photo; may be null
  ChatPhoto? photo;

  /// True, if the user is blocked by the current user
  Bool? is_blocked;

  /// True, if the user can be called
  Bool? can_be_called;

  /// True, if a video call can be created with the user
  Bool? supports_video_calls;

  /// True, if the user can't be called due to their privacy settings
  Bool? has_private_calls;

  /// True, if the user can't be linked in forwarded messages due to their privacy settings
  Bool? has_private_forwards;

  /// True, if the current user needs to explicitly allow to share their phone number with the user when the method addContact is used
  Bool? need_phone_number_privacy_exception;

  /// A short user bio
  string? bio;

  /// Number of group chats where both the other user and the current user are a member; 0 for the current user
  int32? group_in_common_count;

  /// For bots, information about the bot; may be null
  BotInfo? bot_info;

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
    this.group_in_common_count,
    this.bot_info,
  });

  UserFullInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
    }
    is_blocked = map['is_blocked'];
    can_be_called = map['can_be_called'];
    supports_video_calls = map['supports_video_calls'];
    has_private_calls = map['has_private_calls'];
    has_private_forwards = map['has_private_forwards'];
    need_phone_number_privacy_exception = map['need_phone_number_privacy_exception'];
    bio = map['bio'];
    group_in_common_count = map['group_in_common_count'];
    if (map['bot_info'] != null) {
      bot_info = TdApiMap.fromMap(map['bot_info']) as BotInfo;
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
      'group_in_common_count': group_in_common_count?.toMap(skipNulls: skipNulls),
      'bot_info': bot_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/premium_payment_option.dart';
import 'package:td_json_client/api/object/bot_info.dart';

/// Contains full information about a user
class UserFullInfo extends TdObject {
  String get tdType => 'userFullInfo';

  /// User profile photo set by the current user for the contact; may be null. If null and user.profile_photo is null, then the photo is empty; otherwise, it is unknown.
  /// If non-null, then it is the same photo as in user.profile_photo and chat.photo. This photo isn't returned in the list of user photos
  ChatPhoto? personal_photo;

  /// User profile photo; may be null. If null and user.profile_photo is null, then the photo is empty; otherwise, it is unknown.
  /// If non-null and personal_photo is null, then it is the same photo as in user.profile_photo and chat.photo
  ChatPhoto? photo;

  /// User profile photo visible if the main photo is hidden by privacy settings; may be null. If null and user.profile_photo is null, then the photo is empty; otherwise, it is unknown.
  /// If non-null and both photo and personal_photo are null, then it is the same photo as in user.profile_photo and chat.photo. This photo isn't returned in the list of user photos
  ChatPhoto? public_photo;

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

  /// True, if voice and video notes can't be sent or forwarded to the user
  Bool? has_restricted_voice_and_video_note_messages;

  /// True, if the current user needs to explicitly allow to share their phone number with the user when the method addContact is used
  Bool? need_phone_number_privacy_exception;

  /// A short user bio; may be null for bots
  FormattedText? bio;

  /// The list of available options for gifting Telegram Premium to the user
  vector<PremiumPaymentOption>? premium_gift_options;

  /// Number of group chats where both the other user and the current user are a member; 0 for the current user
  int32? group_in_common_count;

  /// For bots, information about the bot; may be null
  BotInfo? bot_info;

  UserFullInfo({
    super.extra,
    super.client_id,
    this.personal_photo,
    this.photo,
    this.public_photo,
    this.is_blocked,
    this.can_be_called,
    this.supports_video_calls,
    this.has_private_calls,
    this.has_private_forwards,
    this.has_restricted_voice_and_video_note_messages,
    this.need_phone_number_privacy_exception,
    this.bio,
    this.premium_gift_options,
    this.group_in_common_count,
    this.bot_info,
  });

  UserFullInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['personal_photo'] != null) {
      personal_photo = TdApiMap.fromMap(map['personal_photo']) as ChatPhoto;
    }
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
    }
    if (map['public_photo'] != null) {
      public_photo = TdApiMap.fromMap(map['public_photo']) as ChatPhoto;
    }
    is_blocked = map['is_blocked'];
    can_be_called = map['can_be_called'];
    supports_video_calls = map['supports_video_calls'];
    has_private_calls = map['has_private_calls'];
    has_private_forwards = map['has_private_forwards'];
    has_restricted_voice_and_video_note_messages =
        map['has_restricted_voice_and_video_note_messages'];
    need_phone_number_privacy_exception =
        map['need_phone_number_privacy_exception'];
    if (map['bio'] != null) {
      bio = TdApiMap.fromMap(map['bio']) as FormattedText;
    }
    if (map['premium_gift_options'] != null) {
      premium_gift_options = [];
      for (var someValue in map['premium_gift_options']) {
        if (someValue != null) {
          premium_gift_options
              ?.add(TdApiMap.fromMap(someValue) as PremiumPaymentOption);
        }
      }
    }
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
      'personal_photo': personal_photo?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'public_photo': public_photo?.toMap(skipNulls: skipNulls),
      'is_blocked': is_blocked?.toMap(skipNulls: skipNulls),
      'can_be_called': can_be_called?.toMap(skipNulls: skipNulls),
      'supports_video_calls': supports_video_calls?.toMap(skipNulls: skipNulls),
      'has_private_calls': has_private_calls?.toMap(skipNulls: skipNulls),
      'has_private_forwards': has_private_forwards?.toMap(skipNulls: skipNulls),
      'has_restricted_voice_and_video_note_messages':
          has_restricted_voice_and_video_note_messages?.toMap(
              skipNulls: skipNulls),
      'need_phone_number_privacy_exception':
          need_phone_number_privacy_exception?.toMap(skipNulls: skipNulls),
      'bio': bio?.toMap(skipNulls: skipNulls),
      'premium_gift_options': premium_gift_options?.toMap(skipNulls: skipNulls),
      'group_in_common_count':
          group_in_common_count?.toMap(skipNulls: skipNulls),
      'bot_info': bot_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

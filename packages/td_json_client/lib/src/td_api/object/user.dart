import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/usernames.dart';
import 'package:td_json_client/src/td_api/object/user_status.dart';
import 'package:td_json_client/src/td_api/object/profile_photo.dart';
import 'package:td_json_client/src/td_api/object/emoji_status.dart';
import 'package:td_json_client/src/td_api/object/user_type.dart';

/// Represents a user
class User extends TdObject {
  String get tdType => 'user';

  /// User identifier
  int53? id;

  /// First name of the user
  string? first_name;

  /// Last name of the user
  string? last_name;

  /// Usernames of the user; may be null
  Usernames? usernames;

  /// Phone number of the user
  string? phone_number;

  /// Current online status of the user
  UserStatus? status;

  /// Profile photo of the user; may be null
  ProfilePhoto? profile_photo;

  /// Emoji status to be shown instead of the default Telegram Premium badge; may be null. For Telegram Premium users only
  EmojiStatus? emoji_status;

  /// The user is a contact of the current user
  Bool? is_contact;

  /// The user is a contact of the current user and the current user is a contact of the user
  Bool? is_mutual_contact;

  /// True, if the user is verified
  Bool? is_verified;

  /// True, if the user is a Telegram Premium user
  Bool? is_premium;

  /// True, if the user is Telegram support account
  Bool? is_support;

  /// If non-empty, it contains a human-readable description of the reason why access to this user must be restricted
  string? restriction_reason;

  /// True, if many users reported this user as a scam
  Bool? is_scam;

  /// True, if many users reported this user as a fake account
  Bool? is_fake;

  /// If false, the user is inaccessible, and the only information known about the user is inside this class. Identifier of the user can't be passed to any method
  Bool? have_access;

  /// Type of the user
  UserType? type;

  /// IETF language tag of the user's language; only available to bots
  string? language_code;

  /// True, if the user added the current bot to attachment menu; only available to bots
  Bool? added_to_attachment_menu;

  User({
    super.extra,
    super.client_id,
    this.id,
    this.first_name,
    this.last_name,
    this.usernames,
    this.phone_number,
    this.status,
    this.profile_photo,
    this.emoji_status,
    this.is_contact,
    this.is_mutual_contact,
    this.is_verified,
    this.is_premium,
    this.is_support,
    this.restriction_reason,
    this.is_scam,
    this.is_fake,
    this.have_access,
    this.type,
    this.language_code,
    this.added_to_attachment_menu,
  });

  User.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    first_name = map['first_name'];
    last_name = map['last_name'];
    if (map['usernames'] != null) {
      usernames = TdApiMap.fromMap(map['usernames']) as Usernames;
    }
    phone_number = map['phone_number'];
    if (map['status'] != null) {
      status = TdApiMap.fromMap(map['status']) as UserStatus;
    }
    if (map['profile_photo'] != null) {
      profile_photo = TdApiMap.fromMap(map['profile_photo']) as ProfilePhoto;
    }
    if (map['emoji_status'] != null) {
      emoji_status = TdApiMap.fromMap(map['emoji_status']) as EmojiStatus;
    }
    is_contact = map['is_contact'];
    is_mutual_contact = map['is_mutual_contact'];
    is_verified = map['is_verified'];
    is_premium = map['is_premium'];
    is_support = map['is_support'];
    restriction_reason = map['restriction_reason'];
    is_scam = map['is_scam'];
    is_fake = map['is_fake'];
    have_access = map['have_access'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as UserType;
    }
    language_code = map['language_code'];
    added_to_attachment_menu = map['added_to_attachment_menu'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'first_name': first_name?.toMap(skipNulls: skipNulls),
      'last_name': last_name?.toMap(skipNulls: skipNulls),
      'usernames': usernames?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
      'status': status?.toMap(skipNulls: skipNulls),
      'profile_photo': profile_photo?.toMap(skipNulls: skipNulls),
      'emoji_status': emoji_status?.toMap(skipNulls: skipNulls),
      'is_contact': is_contact?.toMap(skipNulls: skipNulls),
      'is_mutual_contact': is_mutual_contact?.toMap(skipNulls: skipNulls),
      'is_verified': is_verified?.toMap(skipNulls: skipNulls),
      'is_premium': is_premium?.toMap(skipNulls: skipNulls),
      'is_support': is_support?.toMap(skipNulls: skipNulls),
      'restriction_reason': restriction_reason?.toMap(skipNulls: skipNulls),
      'is_scam': is_scam?.toMap(skipNulls: skipNulls),
      'is_fake': is_fake?.toMap(skipNulls: skipNulls),
      'have_access': have_access?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
      'added_to_attachment_menu':
          added_to_attachment_menu?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

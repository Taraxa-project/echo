import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/user_status.dart';
import 'package:td_json_client/api/object/profile_photo.dart';
import 'package:td_json_client/api/object/user_type.dart';

class User extends TdObject {
  String get tdType => 'user';

  String? extra;
  int? client_id;
  int53? id;
  string? first_name;
  string? last_name;
  string? username;
  string? phone_number;
  UserStatus? status;
  ProfilePhoto? profile_photo;
  Bool? is_contact;
  Bool? is_mutual_contact;
  Bool? is_verified;
  Bool? is_support;
  string? restriction_reason;
  Bool? is_scam;
  Bool? is_fake;
  Bool? have_access;
  UserType? type;
  string? language_code;

  User({
    this.extra,
    this.client_id,
    this.id,
    this.first_name,
    this.last_name,
    this.username,
    this.phone_number,
    this.status,
    this.profile_photo,
    this.is_contact,
    this.is_mutual_contact,
    this.is_verified,
    this.is_support,
    this.restriction_reason,
    this.is_scam,
    this.is_fake,
    this.have_access,
    this.type,
    this.language_code,
  });

  User.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    first_name = map['first_name'];
    last_name = map['last_name'];
    username = map['username'];
    phone_number = map['phone_number'];
    status = TdApiMap.fromMap(map['status']) as UserStatus;
    profile_photo = TdApiMap.fromMap(map['profile_photo']) as ProfilePhoto;
    is_contact = map['is_contact'];
    is_mutual_contact = map['is_mutual_contact'];
    is_verified = map['is_verified'];
    is_support = map['is_support'];
    restriction_reason = map['restriction_reason'];
    is_scam = map['is_scam'];
    is_fake = map['is_fake'];
    have_access = map['have_access'];
    type = TdApiMap.fromMap(map['type']) as UserType;
    language_code = map['language_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'first_name': first_name?.toMap(skipNulls: skipNulls),
      'last_name': last_name?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
      'status': status?.toMap(skipNulls: skipNulls),
      'profile_photo': profile_photo?.toMap(skipNulls: skipNulls),
      'is_contact': is_contact?.toMap(skipNulls: skipNulls),
      'is_mutual_contact': is_mutual_contact?.toMap(skipNulls: skipNulls),
      'is_verified': is_verified?.toMap(skipNulls: skipNulls),
      'is_support': is_support?.toMap(skipNulls: skipNulls),
      'restriction_reason': restriction_reason?.toMap(skipNulls: skipNulls),
      'is_scam': is_scam?.toMap(skipNulls: skipNulls),
      'is_fake': is_fake?.toMap(skipNulls: skipNulls),
      'have_access': have_access?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

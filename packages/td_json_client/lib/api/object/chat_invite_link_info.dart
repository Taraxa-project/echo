import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_type.dart';
import 'package:td_json_client/api/object/chat_photo_info.dart';


/// Contains information about a chat invite link
class ChatInviteLinkInfo extends TdObject {
  String get tdType => 'chatInviteLinkInfo';

  String? extra;
  int? client_id;

  /// Chat identifier of the invite link; 0 if the user has no access to the chat before joining
  int53? chat_id;

  /// If non-zero, the amount of time for which read access to the chat will remain available, in seconds
  int32? accessible_for;

  /// Type of the chat
  ChatType? type;

  /// Title of the chat
  string? title;

  /// Chat photo; may be null
  ChatPhotoInfo? photo;

  string? description;

  /// Number of members in the chat
  int32? member_count;

  /// User identifiers of some chat members that may be known to the current user
  vector<int53>? member_user_ids;

  /// True, if the link only creates join request
  Bool? creates_join_request;

  /// True, if the chat is a public supergroup or channel, i.e. it has a username or it is a location-based supergroup
  Bool? is_public;

  ChatInviteLinkInfo({
    this.extra,
    this.client_id,
    this.chat_id,
    this.accessible_for,
    this.type,
    this.title,
    this.photo,
    this.description,
    this.member_count,
    this.member_user_ids,
    this.creates_join_request,
    this.is_public,
  });

  ChatInviteLinkInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    accessible_for = map['accessible_for'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as ChatType;
    }
    title = map['title'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhotoInfo;
    }
    description = map['description'];
    member_count = map['member_count'];
    if (map['member_user_ids'] != null) {
      member_user_ids = [];
      for (var someValue in map['member_user_ids']) {
        member_user_ids?.add(someValue);
      }
    }
    creates_join_request = map['creates_join_request'];
    is_public = map['is_public'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'accessible_for': accessible_for?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'member_count': member_count?.toMap(skipNulls: skipNulls),
      'member_user_ids': member_user_ids?.toMap(skipNulls: skipNulls),
      'creates_join_request': creates_join_request?.toMap(skipNulls: skipNulls),
      'is_public': is_public?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

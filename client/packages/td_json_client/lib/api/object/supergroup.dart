import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/usernames.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';

/// Represents a supergroup or channel with zero or more members (subscribers in the case of channels). From the point of view of the system, a channel is a special kind of a supergroup:
/// only administrators can post and see the list of members, and posts from all administrators use the name and photo of the channel instead of individual names and profile photos.
/// Unlike supergroups, channels can have an unlimited number of subscribers
class Supergroup extends TdObject {
  String get tdType => 'supergroup';

  /// Supergroup or channel identifier
  int53? id;

  /// Usernames of the supergroup or channel; may be null
  Usernames? usernames;

  /// Point in time (Unix timestamp) when the current user joined, or the point in time when the supergroup or channel was created, in case the user is not a member
  int32? date;

  /// Status of the current user in the supergroup or channel; custom title will always be empty
  ChatMemberStatus? status;

  /// Number of members in the supergroup or channel; 0 if unknown. Currently, it is guaranteed to be known only if the supergroup or channel was received
  /// through searchPublicChats, searchChatsNearby, getInactiveSupergroupChats, getSuitableDiscussionChats, getGroupsInCommon, or getUserPrivacySettingRules
  int32? member_count;

  /// True, if the channel has a discussion group, or the supergroup is the designated discussion group for a channel
  Bool? has_linked_chat;

  /// True, if the supergroup is connected to a location, i.e. the supergroup is a location-based supergroup
  Bool? has_location;

  /// True, if messages sent to the channel need to contain information about the sender. This field is only applicable to channels
  Bool? sign_messages;

  /// True, if users need to join the supergroup before they can send messages. Always true for channels and non-discussion supergroups
  Bool? join_to_send_messages;

  /// True, if all users directly joining the supergroup need to be approved by supergroup administrators. Always false for channels and supergroups without username, location, or a linked chat
  Bool? join_by_request;

  /// True, if the slow mode is enabled in the supergroup
  Bool? is_slow_mode_enabled;

  /// True, if the supergroup is a channel
  Bool? is_channel;

  /// True, if the supergroup is a broadcast group, i.e. only administrators can send messages and there is no limit on the number of members
  Bool? is_broadcast_group;

  /// True, if the supergroup must be shown as a forum by default
  Bool? is_forum;

  /// True, if the supergroup or channel is verified
  Bool? is_verified;

  /// If non-empty, contains a human-readable description of the reason why access to this supergroup or channel must be restricted
  string? restriction_reason;

  /// True, if many users reported this supergroup or channel as a scam
  Bool? is_scam;

  /// True, if many users reported this supergroup or channel as a fake account
  Bool? is_fake;

  Supergroup({
    super.extra,
    super.client_id,
    this.id,
    this.usernames,
    this.date,
    this.status,
    this.member_count,
    this.has_linked_chat,
    this.has_location,
    this.sign_messages,
    this.join_to_send_messages,
    this.join_by_request,
    this.is_slow_mode_enabled,
    this.is_channel,
    this.is_broadcast_group,
    this.is_forum,
    this.is_verified,
    this.restriction_reason,
    this.is_scam,
    this.is_fake,
  });

  Supergroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['usernames'] != null) {
      usernames = TdApiMap.fromMap(map['usernames']) as Usernames;
    }
    date = map['date'];
    if (map['status'] != null) {
      status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
    }
    member_count = map['member_count'];
    has_linked_chat = map['has_linked_chat'];
    has_location = map['has_location'];
    sign_messages = map['sign_messages'];
    join_to_send_messages = map['join_to_send_messages'];
    join_by_request = map['join_by_request'];
    is_slow_mode_enabled = map['is_slow_mode_enabled'];
    is_channel = map['is_channel'];
    is_broadcast_group = map['is_broadcast_group'];
    is_forum = map['is_forum'];
    is_verified = map['is_verified'];
    restriction_reason = map['restriction_reason'];
    is_scam = map['is_scam'];
    is_fake = map['is_fake'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'usernames': usernames?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'status': status?.toMap(skipNulls: skipNulls),
      'member_count': member_count?.toMap(skipNulls: skipNulls),
      'has_linked_chat': has_linked_chat?.toMap(skipNulls: skipNulls),
      'has_location': has_location?.toMap(skipNulls: skipNulls),
      'sign_messages': sign_messages?.toMap(skipNulls: skipNulls),
      'join_to_send_messages':
          join_to_send_messages?.toMap(skipNulls: skipNulls),
      'join_by_request': join_by_request?.toMap(skipNulls: skipNulls),
      'is_slow_mode_enabled': is_slow_mode_enabled?.toMap(skipNulls: skipNulls),
      'is_channel': is_channel?.toMap(skipNulls: skipNulls),
      'is_broadcast_group': is_broadcast_group?.toMap(skipNulls: skipNulls),
      'is_forum': is_forum?.toMap(skipNulls: skipNulls),
      'is_verified': is_verified?.toMap(skipNulls: skipNulls),
      'restriction_reason': restriction_reason?.toMap(skipNulls: skipNulls),
      'is_scam': is_scam?.toMap(skipNulls: skipNulls),
      'is_fake': is_fake?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

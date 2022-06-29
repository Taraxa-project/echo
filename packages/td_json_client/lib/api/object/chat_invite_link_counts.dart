import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_invite_link_count.dart';


/// Contains a list of chat invite link counts 
class ChatInviteLinkCounts extends TdObject {
  String get tdType => 'chatInviteLinkCounts';

  String? extra;
  int? client_id;

  /// List of invite link counts
  vector<ChatInviteLinkCount>? invite_link_counts;

  ChatInviteLinkCounts({
    this.extra,
    this.client_id,
    this.invite_link_counts,
  });

  ChatInviteLinkCounts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['invite_link_counts'] != null) {
      invite_link_counts = [];
      for (var someValue in map['invite_link_counts']) {
        if (someValue != null) {
          invite_link_counts?.add(TdApiMap.fromMap(someValue) as ChatInviteLinkCount);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invite_link_counts': invite_link_counts?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

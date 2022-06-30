import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';


/// Represents a basic group of 0-200 users (must be upgraded to a supergroup to accommodate more than 200 users)
class BasicGroup extends TdObject {
  String get tdType => 'basicGroup';


  /// Group identifier
  int53? id;

  /// Number of members in the group
  int32? member_count;

  /// Status of the current user in the group
  ChatMemberStatus? status;

  /// True, if the group is active
  Bool? is_active;

  /// Identifier of the supergroup to which this group was upgraded; 0 if none
  int53? upgraded_to_supergroup_id;

  BasicGroup({
    super.extra,
    super.client_id,
    this.id,
    this.member_count,
    this.status,
    this.is_active,
    this.upgraded_to_supergroup_id,
  });

  BasicGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    member_count = map['member_count'];
    if (map['status'] != null) {
      status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
    }
    is_active = map['is_active'];
    upgraded_to_supergroup_id = map['upgraded_to_supergroup_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'member_count': member_count?.toMap(skipNulls: skipNulls),
      'status': status?.toMap(skipNulls: skipNulls),
      'is_active': is_active?.toMap(skipNulls: skipNulls),
      'upgraded_to_supergroup_id': upgraded_to_supergroup_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

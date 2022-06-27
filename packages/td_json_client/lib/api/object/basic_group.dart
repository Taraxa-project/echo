import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';

class BasicGroup extends TdObject {
  String get tdType => 'basicGroup';

  String? extra;
  int? client_id;
  int53? id;
  int32? member_count;
  ChatMemberStatus? status;
  Bool? is_active;
  int53? upgraded_to_supergroup_id;

  BasicGroup({
    this.extra,
    this.client_id,
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
    status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
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

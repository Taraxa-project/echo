import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/supergroup_members_filter.dart';


/// Returns information about members or banned users in a supergroup or channel. Can be used only if supergroupFullInfo.can_get_members == true; additionally, administrator privileges may be required for some filters 
class GetSupergroupMembers extends TdFunction {
  String get tdType => 'getSupergroupMembers';
  String get tdReturnType => 'ChatMembers';

  String? extra;
  int? client_id;

  /// Identifier of the supergroup or channel
  int53? supergroup_id;

  /// The type of users to return; pass null to use supergroupMembersFilterRecent 
  SupergroupMembersFilter? filter;

  /// Number of users to skip 
  int32? offset;

  /// The maximum number of users be returned; up to 200
  int32? limit;

  GetSupergroupMembers({
    this.extra,
    this.client_id,
    this.supergroup_id,
    this.filter,
    this.offset,
    this.limit,
  });

  GetSupergroupMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    filter = TdApiMap.fromMap(map['filter']) as SupergroupMembersFilter;
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

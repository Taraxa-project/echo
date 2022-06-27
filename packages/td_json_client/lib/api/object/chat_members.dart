import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_member.dart';


/// Contains a list of chat members 
class ChatMembers extends TdObject {
  String get tdType => 'chatMembers';

  String? extra;
  int? client_id;

  /// Approximate total number of chat members found 
  int32? total_count;

  /// A list of chat members
  vector<ChatMember>? members;

  ChatMembers({
    this.extra,
    this.client_id,
    this.total_count,
    this.members,
  });

  ChatMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['members']) {
      members = [];
      for (var someValue in map['members']) {
        members?.add(TdApiMap.fromMap(someValue) as ChatMember);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'members': members?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_nearby.dart';

class ChatsNearby extends TdObject {
  String get tdType => 'chatsNearby';

  String? extra;
  int? client_id;
  vector<ChatNearby>? users_nearby;
  vector<ChatNearby>? supergroups_nearby;

  ChatsNearby({
    this.extra,
    this.client_id,
    this.users_nearby,
    this.supergroups_nearby,
  });

  ChatsNearby.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['users_nearby']) {
      users_nearby = [];
      for (var someValue in map['users_nearby']) {
        users_nearby?.add(TdApiMap.fromMap(someValue) as ChatNearby);
      }
    }
    if (map['supergroups_nearby']) {
      supergroups_nearby = [];
      for (var someValue in map['supergroups_nearby']) {
        supergroups_nearby?.add(TdApiMap.fromMap(someValue) as ChatNearby);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'users_nearby': users_nearby?.toMap(skipNulls: skipNulls),
      'supergroups_nearby': supergroups_nearby?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

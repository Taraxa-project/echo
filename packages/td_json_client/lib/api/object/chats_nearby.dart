import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_nearby.dart';


/// Represents a list of chats located nearby 
class ChatsNearby extends TdObject {
  String get tdType => 'chatsNearby';

  String? extra;
  int? client_id;

  /// List of users nearby 
  vector<ChatNearby>? users_nearby;

  /// List of location-based supergroups nearby
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
    if (map['users_nearby'] != null) {
      users_nearby = [];
      for (var someValue in map['users_nearby']) {
        if (someValue != null) {
          users_nearby?.add(TdApiMap.fromMap(someValue) as ChatNearby);
        }
      }
    }
    if (map['supergroups_nearby'] != null) {
      supergroups_nearby = [];
      for (var someValue in map['supergroups_nearby']) {
        if (someValue != null) {
          supergroups_nearby?.add(TdApiMap.fromMap(someValue) as ChatNearby);
        }
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

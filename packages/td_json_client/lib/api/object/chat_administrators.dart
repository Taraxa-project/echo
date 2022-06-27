import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_administrator.dart';

class ChatAdministrators extends TdObject {
  String get tdType => 'chatAdministrators';

  String? extra;
  int? client_id;
  vector<ChatAdministrator>? administrators;

  ChatAdministrators({
    this.extra,
    this.client_id,
    this.administrators,
  });

  ChatAdministrators.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['administrators']) {
      administrators = [];
      for (var someValue in map['administrators']) {
        administrators?.add(TdApiMap.fromMap(someValue) as ChatAdministrator);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'administrators': administrators?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

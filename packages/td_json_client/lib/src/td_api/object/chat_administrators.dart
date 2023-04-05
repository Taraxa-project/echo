import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_administrator.dart';

/// Represents a list of chat administrators
class ChatAdministrators extends TdObject {
  String get tdType => 'chatAdministrators';

  /// A list of chat administrators
  vector<ChatAdministrator>? administrators;

  ChatAdministrators({
    super.extra,
    super.client_id,
    this.administrators,
  });

  ChatAdministrators.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['administrators'] != null) {
      administrators = [];
      for (var someValue in map['administrators']) {
        if (someValue != null) {
          administrators?.add(TdApiMap.fromMap(someValue) as ChatAdministrator);
        }
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

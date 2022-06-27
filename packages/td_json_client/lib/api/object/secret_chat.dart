import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/secret_chat_state.dart';

class SecretChat extends TdObject {
  String get tdType => 'secretChat';

  string? extra;
  int? client_id;
  int32? id;
  int53? user_id;
  SecretChatState? state;
  Bool? is_outbound;
  bytes? key_hash;
  int32? layer;

  SecretChat({
    this.extra,
    this.client_id,
    this.id,
    this.user_id,
    this.state,
    this.is_outbound,
    this.key_hash,
    this.layer,
  });

  SecretChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    user_id = map['user_id'];
    state = TdApiMap.fromMap(map['state']) as SecretChatState;
    is_outbound = map['is_outbound'];
    key_hash = map['key_hash'];
    layer = map['layer'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'state': state?.toMap(skipNulls: skipNulls),
      'is_outbound': is_outbound?.toMap(skipNulls: skipNulls),
      'key_hash': key_hash?.toMap(skipNulls: skipNulls),
      'layer': layer?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

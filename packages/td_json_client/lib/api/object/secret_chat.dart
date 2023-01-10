import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/secret_chat_state.dart';


/// Represents a secret chat
class SecretChat extends TdObject {
  String get tdType => 'secretChat';


  /// Secret chat identifier
  int32? id;

  /// Identifier of the chat partner
  int53? user_id;

  /// State of the secret chat
  SecretChatState? state;

  /// True, if the chat was created by the current user; otherwise false
  Bool? is_outbound;

  /// Hash of the currently used key for comparison with the hash of the chat partner's key. This is a string of 36 little-endian bytes, which must be split into groups of 2 bits, each denoting a pixel of one of 4 colors FFFFFF, D5E6F3, 2D5775, and 2F99C9.
  /// The pixels must be used to make a 12x12 square image filled from left to right, top to bottom. Alternatively, the first 32 bytes of the hash can be converted to the hexadecimal format and printed as 32 2-digit hex numbers
  bytes? key_hash;

  /// Secret chat layer; determines features supported by the chat partner's application. Nested text entities and underline and strikethrough entities are supported if the layer >= 101, files bigger than 2000MB are supported if the layer >= 143, spoiler and custom emoji text entities are supported if the layer >= 144
  int32? layer;

  SecretChat({
    super.extra,
    super.client_id,
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
    if (map['state'] != null) {
      state = TdApiMap.fromMap(map['state']) as SecretChatState;
    }
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

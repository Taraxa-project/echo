import 'package:td_json_client/api/base.dart';

abstract class CallServerType extends TdObject {}

class CallServerTypeTelegramReflector extends CallServerType {
  String get tdType => 'callServerTypeTelegramReflector';

  string? extra;
  int? client_id;
  bytes? peer_tag;

  CallServerTypeTelegramReflector({
    this.extra,
    this.client_id,
    this.peer_tag,
  });

  CallServerTypeTelegramReflector.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    peer_tag = map['peer_tag'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'peer_tag': peer_tag?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CallServerTypeWebrtc extends CallServerType {
  String get tdType => 'callServerTypeWebrtc';

  string? extra;
  int? client_id;
  string? username;
  string? password;
  Bool? supports_turn;
  Bool? supports_stun;

  CallServerTypeWebrtc({
    this.extra,
    this.client_id,
    this.username,
    this.password,
    this.supports_turn,
    this.supports_stun,
  });

  CallServerTypeWebrtc.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    username = map['username'];
    password = map['password'];
    supports_turn = map['supports_turn'];
    supports_stun = map['supports_stun'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
      'supports_turn': supports_turn?.toMap(skipNulls: skipNulls),
      'supports_stun': supports_stun?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

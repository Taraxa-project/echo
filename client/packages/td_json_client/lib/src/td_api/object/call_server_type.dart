import 'package:td_json_client/src/td_api/td.dart';

/// Describes the type of a call server
abstract class CallServerType extends TdObject {
  CallServerType({super.extra, super.client_id});
}

/// A Telegram call reflector
class CallServerTypeTelegramReflector extends CallServerType {
  String get tdType => 'callServerTypeTelegramReflector';

  /// A peer tag to be used with the reflector
  bytes? peer_tag;

  /// True, if the server uses TCP instead of UDP
  Bool? is_tcp;

  CallServerTypeTelegramReflector({
    super.extra,
    super.client_id,
    this.peer_tag,
    this.is_tcp,
  });

  CallServerTypeTelegramReflector.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    peer_tag = map['peer_tag'];
    is_tcp = map['is_tcp'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'peer_tag': peer_tag?.toMap(skipNulls: skipNulls),
      'is_tcp': is_tcp?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A WebRTC server
class CallServerTypeWebrtc extends CallServerType {
  String get tdType => 'callServerTypeWebrtc';

  /// Username to be used for authentication
  string? username;

  /// Authentication password
  string? password;

  /// True, if the server supports TURN
  Bool? supports_turn;

  /// True, if the server supports STUN
  Bool? supports_stun;

  CallServerTypeWebrtc({
    super.extra,
    super.client_id,
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

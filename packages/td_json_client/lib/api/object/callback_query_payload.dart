import 'package:td_json_client/api/base.dart';

abstract class CallbackQueryPayload extends TdObject {}

class CallbackQueryPayloadData extends CallbackQueryPayload {
  String get tdType => 'callbackQueryPayloadData';

  string? extra;
  int? client_id;
  bytes? data;

  CallbackQueryPayloadData({
    this.extra,
    this.client_id,
    this.data,
  });

  CallbackQueryPayloadData.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CallbackQueryPayloadDataWithPassword extends CallbackQueryPayload {
  String get tdType => 'callbackQueryPayloadDataWithPassword';

  string? extra;
  int? client_id;
  string? password;
  bytes? data;

  CallbackQueryPayloadDataWithPassword({
    this.extra,
    this.client_id,
    this.password,
    this.data,
  });

  CallbackQueryPayloadDataWithPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    password = map['password'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CallbackQueryPayloadGame extends CallbackQueryPayload {
  String get tdType => 'callbackQueryPayloadGame';

  string? extra;
  int? client_id;
  string? game_short_name;

  CallbackQueryPayloadGame({
    this.extra,
    this.client_id,
    this.game_short_name,
  });

  CallbackQueryPayloadGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    game_short_name = map['game_short_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'game_short_name': game_short_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
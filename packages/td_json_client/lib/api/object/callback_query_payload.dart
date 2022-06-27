import 'package:td_json_client/api/base.dart';

/// Represents a payload of a callback query
abstract class CallbackQueryPayload extends TdObject {}


/// The payload for a general callback button 
class CallbackQueryPayloadData extends CallbackQueryPayload {
  String get tdType => 'callbackQueryPayloadData';

  String? extra;
  int? client_id;

  /// Data that was attached to the callback button
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

/// The payload for a callback button requiring password 
class CallbackQueryPayloadDataWithPassword extends CallbackQueryPayload {
  String get tdType => 'callbackQueryPayloadDataWithPassword';

  String? extra;
  int? client_id;

  /// The password for the current user 
  string? password;

  /// Data that was attached to the callback button
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

/// The payload for a game callback button 
class CallbackQueryPayloadGame extends CallbackQueryPayload {
  String get tdType => 'callbackQueryPayloadGame';

  String? extra;
  int? client_id;

  /// A short name of the game that was attached to the callback button
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

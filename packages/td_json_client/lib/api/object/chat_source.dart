import 'package:td_json_client/api/base.dart';

/// Describes a reason why an external chat is shown in a chat list
abstract class ChatSource extends TdObject {}


/// The chat is sponsored by the user's MTProxy server
class ChatSourceMtprotoProxy extends ChatSource {
  String get tdType => 'chatSourceMtprotoProxy';

  String? extra;
  int? client_id;

  ChatSourceMtprotoProxy({
    this.extra,
    this.client_id,
  });

  ChatSourceMtprotoProxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat contains a public service announcement 
class ChatSourcePublicServiceAnnouncement extends ChatSource {
  String get tdType => 'chatSourcePublicServiceAnnouncement';

  String? extra;
  int? client_id;

  /// The type of the announcement 
  string? type;

  /// The text of the announcement
  string? text;

  ChatSourcePublicServiceAnnouncement({
    this.extra,
    this.client_id,
    this.type,
    this.text,
  });

  ChatSourcePublicServiceAnnouncement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = map['type'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

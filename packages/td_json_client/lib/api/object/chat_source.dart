import 'package:td_json_client/api/base.dart';

abstract class ChatSource extends TdObject {}

class ChatSourceMtprotoProxy extends ChatSource {
  String get tdType => 'chatSourceMtprotoProxy';

  string? extra;
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
class ChatSourcePublicServiceAnnouncement extends ChatSource {
  String get tdType => 'chatSourcePublicServiceAnnouncement';

  string? extra;
  int? client_id;
  string? type;
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

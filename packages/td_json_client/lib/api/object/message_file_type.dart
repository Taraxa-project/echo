import 'package:td_json_client/api/base.dart';

abstract class MessageFileType extends TdObject {}

class MessageFileTypePrivate extends MessageFileType {
  String get tdType => 'messageFileTypePrivate';

  string? extra;
  int? client_id;
  string? name;

  MessageFileTypePrivate({
    this.extra,
    this.client_id,
    this.name,
  });

  MessageFileTypePrivate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageFileTypeGroup extends MessageFileType {
  String get tdType => 'messageFileTypeGroup';

  string? extra;
  int? client_id;
  string? title;

  MessageFileTypeGroup({
    this.extra,
    this.client_id,
    this.title,
  });

  MessageFileTypeGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageFileTypeUnknown extends MessageFileType {
  String get tdType => 'messageFileTypeUnknown';

  string? extra;
  int? client_id;

  MessageFileTypeUnknown({
    this.extra,
    this.client_id,
  });

  MessageFileTypeUnknown.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about a file with messages exported from another app
abstract class MessageFileType extends TdObject {
  MessageFileType({super.extra, super.client_id});
}

/// The messages was exported from a private chat
class MessageFileTypePrivate extends MessageFileType {
  String get tdType => 'messageFileTypePrivate';

  /// Name of the other party; may be empty if unrecognized
  string? name;

  MessageFileTypePrivate({
    super.extra,
    super.client_id,
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

/// The messages was exported from a group chat
class MessageFileTypeGroup extends MessageFileType {
  String get tdType => 'messageFileTypeGroup';

  /// Title of the group chat; may be empty if unrecognized
  string? title;

  MessageFileTypeGroup({
    super.extra,
    super.client_id,
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

/// The messages was exported from a chat of unknown type
class MessageFileTypeUnknown extends MessageFileType {
  String get tdType => 'messageFileTypeUnknown';

  MessageFileTypeUnknown({
    super.extra,
    super.client_id,
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

import 'package:td_json_client/api/base.dart';

/// Describes a type of public chats
abstract class PublicChatType extends TdObject {}


/// The chat is public, because it has username
class PublicChatTypeHasUsername extends PublicChatType {
  String get tdType => 'publicChatTypeHasUsername';

  String? extra;
  int? client_id;

  PublicChatTypeHasUsername({
    this.extra,
    this.client_id,
  });

  PublicChatTypeHasUsername.fromMap(Map<String, dynamic> map) {
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

/// The chat is public, because it is a location-based supergroup
class PublicChatTypeIsLocationBased extends PublicChatType {
  String get tdType => 'publicChatTypeIsLocationBased';

  String? extra;
  int? client_id;

  PublicChatTypeIsLocationBased({
    this.extra,
    this.client_id,
  });

  PublicChatTypeIsLocationBased.fromMap(Map<String, dynamic> map) {
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

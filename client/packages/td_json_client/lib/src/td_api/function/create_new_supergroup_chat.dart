import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_location.dart';

/// Creates a new supergroup or channel and sends a corresponding messageSupergroupChatCreate. Returns the newly created chat
class CreateNewSupergroupChat extends TdFunction {
  String get tdType => 'createNewSupergroupChat';
  String get tdReturnType => 'Chat';

  /// Title of the new chat; 1-128 characters
  string? title;

  /// Pass true to create a channel chat
  Bool? is_channel;

  string? description;

  /// Chat location if a location-based supergroup is being created; pass null to create an ordinary supergroup chat
  ChatLocation? location;

  /// Message auto-delete time value, in seconds; must be from 0 up to 365 * 86400 and be divisible by 86400. If 0, then messages aren't deleted automatically
  int32? message_auto_delete_time;

  /// Pass true to create a supergroup for importing messages using importMessage
  Bool? for_import;

  CreateNewSupergroupChat({
    super.extra,
    super.client_id,
    this.title,
    this.is_channel,
    this.description,
    this.location,
    this.message_auto_delete_time,
    this.for_import,
  });

  CreateNewSupergroupChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    is_channel = map['is_channel'];
    description = map['description'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as ChatLocation;
    }
    message_auto_delete_time = map['message_auto_delete_time'];
    for_import = map['for_import'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'is_channel': is_channel?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'message_auto_delete_time': message_auto_delete_time?.toMap(skipNulls: skipNulls),
      'for_import': for_import?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

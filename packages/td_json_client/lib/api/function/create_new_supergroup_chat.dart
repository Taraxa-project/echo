import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_location.dart';

class CreateNewSupergroupChat extends TdFunction {
  String get tdType => 'createNewSupergroupChat';
  String get tdReturnType => 'Chat';

  String? extra;
  int? client_id;
  string? title;
  Bool? is_channel;
  string? description;
  ChatLocation? location;
  Bool? for_import;

  CreateNewSupergroupChat({
    this.extra,
    this.client_id,
    this.title,
    this.is_channel,
    this.description,
    this.location,
    this.for_import,
  });

  CreateNewSupergroupChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    is_channel = map['is_channel'];
    description = map['description'];
    location = TdApiMap.fromMap(map['location']) as ChatLocation;
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
      'for_import': for_import?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Creates a new basic group and sends a corresponding messageBasicGroupChatCreate. Returns the newly created chat
class CreateNewBasicGroupChat extends TdFunction {
  String get tdType => 'createNewBasicGroupChat';
  String get tdReturnType => 'Chat';

  /// Identifiers of users to be added to the basic group
  vector<int53>? user_ids;

  /// Title of the new basic group; 1-128 characters
  string? title;

  /// Message auto-delete time value, in seconds; must be from 0 up to 365 * 86400 and be divisible by 86400. If 0, then messages aren't deleted automatically
  int32? message_auto_delete_time;

  CreateNewBasicGroupChat({
    super.extra,
    super.client_id,
    this.user_ids,
    this.title,
    this.message_auto_delete_time,
  });

  CreateNewBasicGroupChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user_ids'] != null) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
    title = map['title'];
    message_auto_delete_time = map['message_auto_delete_time'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'message_auto_delete_time': message_auto_delete_time?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

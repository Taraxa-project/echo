import 'package:td_json_client/api/base.dart';


/// Creates a new basic group and sends a corresponding messageBasicGroupChatCreate. Returns the newly created chat 
class CreateNewBasicGroupChat extends TdFunction {
  String get tdType => 'createNewBasicGroupChat';
  String get tdReturnType => 'Chat';

  String? extra;
  int? client_id;

  /// Identifiers of users to be added to the basic group 
  vector<int53>? user_ids;

  /// Title of the new basic group; 1-128 characters
  string? title;

  CreateNewBasicGroupChat({
    this.extra,
    this.client_id,
    this.user_ids,
    this.title,
  });

  CreateNewBasicGroupChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user_ids']) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

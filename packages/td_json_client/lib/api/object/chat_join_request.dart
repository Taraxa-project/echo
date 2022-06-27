import 'package:td_json_client/api/base.dart';

class ChatJoinRequest extends TdObject {
  String get tdType => 'chatJoinRequest';

  String? extra;
  int? client_id;
  int53? user_id;
  int32? date;
  string? bio;

  ChatJoinRequest({
    this.extra,
    this.client_id,
    this.user_id,
    this.date,
    this.bio,
  });

  ChatJoinRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    date = map['date'];
    bio = map['bio'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'bio': bio?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

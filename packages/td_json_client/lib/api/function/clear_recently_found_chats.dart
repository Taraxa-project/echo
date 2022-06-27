import 'package:td_json_client/api/base.dart';


/// Clears the list of recently found chats
class ClearRecentlyFoundChats extends TdFunction {
  String get tdType => 'clearRecentlyFoundChats';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  ClearRecentlyFoundChats({
    this.extra,
    this.client_id,
  });

  ClearRecentlyFoundChats.fromMap(Map<String, dynamic> map) {
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

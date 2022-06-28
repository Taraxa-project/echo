import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';

/// Returns an ordered list of chats from the beginning of a chat list. For informational purposes only. Use loadChats and updates processing instead to maintain chat lists in a consistent state
class GetUpdateNewMessages extends TdFunction {
  String get tdType => 'GetUpdateNewMessages';
  String get tdReturnType => 'Updates';

  String? extra;
  int? client_id;

  /// The new message
  Message? message;

  /// The maximum number of chats to be returned
  int32? limit;

  GetUpdateNewMessages({
    this.extra,
    this.client_id,
    this.message,
    this.limit,
  });

  GetUpdateNewMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

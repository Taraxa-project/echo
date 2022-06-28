import 'package:td_json_client/api/base.dart';


/// Handles a pending join request in a chat 
class ProcessChatJoinRequest extends TdFunction {
  String get tdType => 'processChatJoinRequest';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Identifier of the user that sent the request 
  int53? user_id;

  /// Pass true to approve the request; pass false to decline it
  Bool? approve;

  ProcessChatJoinRequest({
    this.extra,
    this.client_id,
    this.chat_id,
    this.user_id,
    this.approve,
  });

  ProcessChatJoinRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    user_id = map['user_id'];
    approve = map['approve'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'approve': approve?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Changes application-specific data associated with a chat
class SetChatClientData extends TdFunction {
  String get tdType => 'setChatClientData';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// New value of client_data
  string? client_data;

  SetChatClientData({
    super.extra,
    super.client_id,
    this.chat_id,
    this.client_data,
  });

  SetChatClientData.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    client_data = map['client_data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'client_data': client_data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

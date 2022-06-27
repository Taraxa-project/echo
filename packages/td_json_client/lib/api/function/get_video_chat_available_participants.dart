import 'package:td_json_client/api/base.dart';


/// Returns list of participant identifiers, on whose behalf a video chat in the chat can be joined 
class GetVideoChatAvailableParticipants extends TdFunction {
  String get tdType => 'getVideoChatAvailableParticipants';
  String get tdReturnType => 'MessageSenders';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  GetVideoChatAvailableParticipants({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  GetVideoChatAvailableParticipants.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

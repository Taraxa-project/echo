import 'package:td_json_client/api/base.dart';


/// Rates recognized speech in a video note or a voice note message 
class RateSpeechRecognition extends TdFunction {
  String get tdType => 'rateSpeechRecognition';
  String get tdReturnType => 'Ok';


  /// Identifier of the chat to which the message belongs 
  int53? chat_id;

  /// Identifier of the message 
  int53? message_id;

  /// Pass true if the speech recognition is good
  Bool? is_good;

  RateSpeechRecognition({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.is_good,
  });

  RateSpeechRecognition.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    is_good = map['is_good'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'is_good': is_good?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

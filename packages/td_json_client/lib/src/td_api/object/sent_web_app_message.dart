import 'package:td_json_client/src/td_api/td.dart';

/// Information about the message sent by answerWebAppQuery
class SentWebAppMessage extends TdObject {
  String get tdType => 'sentWebAppMessage';

  /// Identifier of the sent inline message, if known
  string? inline_message_id;

  SentWebAppMessage({
    super.extra,
    super.client_id,
    this.inline_message_id,
  });

  SentWebAppMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_message_id = map['inline_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

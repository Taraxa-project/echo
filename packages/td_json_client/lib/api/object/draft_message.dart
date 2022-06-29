import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_message_content.dart';


/// Contains information about a message draft
class DraftMessage extends TdObject {
  String get tdType => 'draftMessage';

  String? extra;
  int? client_id;

  /// Identifier of the replied message; 0 if none
  int53? reply_to_message_id;

  /// Point in time (Unix timestamp) when the draft was created
  int32? date;

  /// Content of the message draft; must be of the type inputMessageText
  InputMessageContent? input_message_text;

  DraftMessage({
    this.extra,
    this.client_id,
    this.reply_to_message_id,
    this.date,
    this.input_message_text,
  });

  DraftMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reply_to_message_id = map['reply_to_message_id'];
    date = map['date'];
    if (map['input_message_text'] != null) {
      input_message_text = TdApiMap.fromMap(map['input_message_text']) as InputMessageContent;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reply_to_message_id': reply_to_message_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'input_message_text': input_message_text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

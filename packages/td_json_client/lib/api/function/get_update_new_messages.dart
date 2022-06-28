import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';

/// Listen to new messages from all subscribed chats
class GetUpdateNewMessages extends TdFunction {
  String get tdType => 'GetUpdateNewMessages';
  String get tdReturnType => 'Updates';

  String? extra;
  int? client_id;

  /// The new message
  FormattedText? text;

  GetUpdateNewMessages({
    this.extra,
    this.client_id,
    this.text,
  });

  GetUpdateNewMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = TdApiMap.fromMap(map['text']) as FormattedText;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

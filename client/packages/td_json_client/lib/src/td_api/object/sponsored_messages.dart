import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sponsored_message.dart';

/// Contains a list of sponsored messages
class SponsoredMessages extends TdObject {
  String get tdType => 'sponsoredMessages';

  /// List of sponsored messages
  vector<SponsoredMessage>? messages;

  /// The minimum number of messages between shown sponsored messages, or 0 if only one sponsored message must be shown after all ordinary messages
  int32? messages_between;

  SponsoredMessages({
    super.extra,
    super.client_id,
    this.messages,
    this.messages_between,
  });

  SponsoredMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['messages'] != null) {
      messages = [];
      for (var someValue in map['messages']) {
        if (someValue != null) {
          messages?.add(TdApiMap.fromMap(someValue) as SponsoredMessage);
        }
      }
    }
    messages_between = map['messages_between'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'messages': messages?.toMap(skipNulls: skipNulls),
      'messages_between': messages_between?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

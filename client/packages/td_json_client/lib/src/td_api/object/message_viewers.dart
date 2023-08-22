import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_viewer.dart';

/// Represents a list of message viewers
class MessageViewers extends TdObject {
  String get tdType => 'messageViewers';

  /// List of message viewers
  vector<MessageViewer>? viewers;

  MessageViewers({
    super.extra,
    super.client_id,
    this.viewers,
  });

  MessageViewers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['viewers'] != null) {
      viewers = [];
      for (var someValue in map['viewers']) {
        if (someValue != null) {
          viewers?.add(TdApiMap.fromMap(someValue) as MessageViewer);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'viewers': viewers?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

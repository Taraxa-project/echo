import 'package:td_json_client/src/td_api/td.dart';

/// Represents a viewer of a message
class MessageViewer extends TdObject {
  String get tdType => 'messageViewer';

  /// User identifier of the viewer
  int53? user_id;

  /// Approximate point in time (Unix timestamp) when the message was viewed
  int32? view_date;

  MessageViewer({
    super.extra,
    super.client_id,
    this.user_id,
    this.view_date,
  });

  MessageViewer.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    view_date = map['view_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'view_date': view_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

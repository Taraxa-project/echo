import 'package:td_json_client/api/base.dart';


/// Describes a forum topic icon 
class ForumTopicIcon extends TdObject {
  String get tdType => 'forumTopicIcon';


  /// Color of the topic icon in RGB format 
  int32? color;

  /// Unique identifier of the custom emoji shown on the topic icon; 0 if none
  int64? custom_emoji_id;

  ForumTopicIcon({
    super.extra,
    super.client_id,
    this.color,
    this.custom_emoji_id,
  });

  ForumTopicIcon.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    color = map['color'];
    custom_emoji_id = map['custom_emoji_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'color': color?.toMap(skipNulls: skipNulls),
      'custom_emoji_id': custom_emoji_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

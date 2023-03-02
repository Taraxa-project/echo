import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/emoji_status.dart';


/// Contains a list of emoji statuses 
class EmojiStatuses extends TdObject {
  String get tdType => 'emojiStatuses';


  /// The list of emoji statuses
  vector<EmojiStatus>? emoji_statuses;

  EmojiStatuses({
    super.extra,
    super.client_id,
    this.emoji_statuses,
  });

  EmojiStatuses.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['emoji_statuses'] != null) {
      emoji_statuses = [];
      for (var someValue in map['emoji_statuses']) {
        if (someValue != null) {
          emoji_statuses?.add(TdApiMap.fromMap(someValue) as EmojiStatus);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji_statuses': emoji_statuses?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

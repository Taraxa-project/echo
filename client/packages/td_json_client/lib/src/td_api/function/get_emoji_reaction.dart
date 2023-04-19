import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about a emoji reaction. Returns a 404 error if the reaction is not found
class GetEmojiReaction extends TdFunction {
  String get tdType => 'getEmojiReaction';
  String get tdReturnType => 'EmojiReaction';

  /// Text representation of the reaction
  string? emoji;

  GetEmojiReaction({
    super.extra,
    super.client_id,
    this.emoji,
  });

  GetEmojiReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    emoji = map['emoji'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

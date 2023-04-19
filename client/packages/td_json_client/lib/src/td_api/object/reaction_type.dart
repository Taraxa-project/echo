import 'package:td_json_client/src/td_api/td.dart';

/// Describes type of message reaction
abstract class ReactionType extends TdObject {
  ReactionType({super.extra, super.client_id});
}

/// A reaction with an emoji
class ReactionTypeEmoji extends ReactionType {
  String get tdType => 'reactionTypeEmoji';

  /// Text representation of the reaction
  string? emoji;

  ReactionTypeEmoji({
    super.extra,
    super.client_id,
    this.emoji,
  });

  ReactionTypeEmoji.fromMap(Map<String, dynamic> map) {
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

/// A reaction with a custom emoji
class ReactionTypeCustomEmoji extends ReactionType {
  String get tdType => 'reactionTypeCustomEmoji';

  /// Unique identifier of the custom emoji
  int64? custom_emoji_id;

  ReactionTypeCustomEmoji({
    super.extra,
    super.client_id,
    this.custom_emoji_id,
  });

  ReactionTypeCustomEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    custom_emoji_id = map['custom_emoji_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'custom_emoji_id': custom_emoji_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

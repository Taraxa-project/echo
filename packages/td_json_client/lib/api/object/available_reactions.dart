import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/available_reaction.dart';


/// Represents a list of reactions that can be added to a message
class AvailableReactions extends TdObject {
  String get tdType => 'availableReactions';


  /// List of reactions to be shown at the top
  vector<AvailableReaction>? top_reactions;

  /// List of recently used reactions
  vector<AvailableReaction>? recent_reactions;

  /// List of popular reactions
  vector<AvailableReaction>? popular_reactions;

  /// True, if custom emoji reactions could be added by Telegram Premium subscribers
  Bool? allow_custom_emoji;

  AvailableReactions({
    super.extra,
    super.client_id,
    this.top_reactions,
    this.recent_reactions,
    this.popular_reactions,
    this.allow_custom_emoji,
  });

  AvailableReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['top_reactions'] != null) {
      top_reactions = [];
      for (var someValue in map['top_reactions']) {
        if (someValue != null) {
          top_reactions?.add(TdApiMap.fromMap(someValue) as AvailableReaction);
        }
      }
    }
    if (map['recent_reactions'] != null) {
      recent_reactions = [];
      for (var someValue in map['recent_reactions']) {
        if (someValue != null) {
          recent_reactions?.add(TdApiMap.fromMap(someValue) as AvailableReaction);
        }
      }
    }
    if (map['popular_reactions'] != null) {
      popular_reactions = [];
      for (var someValue in map['popular_reactions']) {
        if (someValue != null) {
          popular_reactions?.add(TdApiMap.fromMap(someValue) as AvailableReaction);
        }
      }
    }
    allow_custom_emoji = map['allow_custom_emoji'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'top_reactions': top_reactions?.toMap(skipNulls: skipNulls),
      'recent_reactions': recent_reactions?.toMap(skipNulls: skipNulls),
      'popular_reactions': popular_reactions?.toMap(skipNulls: skipNulls),
      'allow_custom_emoji': allow_custom_emoji?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

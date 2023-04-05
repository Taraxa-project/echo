import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/reaction_type.dart';

/// Describes reactions available in the chat
abstract class ChatAvailableReactions extends TdObject {
  ChatAvailableReactions({super.extra, super.client_id});
}

/// All reactions are available in the chat
class ChatAvailableReactionsAll extends ChatAvailableReactions {
  String get tdType => 'chatAvailableReactionsAll';

  ChatAvailableReactionsAll({
    super.extra,
    super.client_id,
  });

  ChatAvailableReactionsAll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Only specific reactions are available in the chat
class ChatAvailableReactionsSome extends ChatAvailableReactions {
  String get tdType => 'chatAvailableReactionsSome';

  /// The list of reactions
  vector<ReactionType>? reactions;

  ChatAvailableReactionsSome({
    super.extra,
    super.client_id,
    this.reactions,
  });

  ChatAvailableReactionsSome.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['reactions'] != null) {
      reactions = [];
      for (var someValue in map['reactions']) {
        if (someValue != null) {
          reactions?.add(TdApiMap.fromMap(someValue) as ReactionType);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reactions': reactions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/available_reaction.dart';


/// Represents a list of available reactions 
class AvailableReactions extends TdObject {
  String get tdType => 'availableReactions';


  /// List of reactions
  vector<AvailableReaction>? reactions;

  AvailableReactions({
    super.extra,
    super.client_id,
    this.reactions,
  });

  AvailableReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['reactions'] != null) {
      reactions = [];
      for (var someValue in map['reactions']) {
        if (someValue != null) {
          reactions?.add(TdApiMap.fromMap(someValue) as AvailableReaction);
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

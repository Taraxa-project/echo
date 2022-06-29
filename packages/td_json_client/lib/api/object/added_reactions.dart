import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/added_reaction.dart';


/// Represents a list of reactions added to a message 
class AddedReactions extends TdObject {
  String get tdType => 'addedReactions';

  String? extra;
  int? client_id;

  /// The total number of found reactions 
  int32? total_count;

  /// The list of added reactions 
  vector<AddedReaction>? reactions;

  /// The offset for the next request. If empty, there are no more results
  string? next_offset;

  AddedReactions({
    this.extra,
    this.client_id,
    this.total_count,
    this.reactions,
    this.next_offset,
  });

  AddedReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['reactions'] != null) {
      reactions = [];
      for (var someValue in map['reactions']) {
        if (someValue != null) {
          reactions?.add(TdApiMap.fromMap(someValue) as AddedReaction);
        }
      }
    }
    next_offset = map['next_offset'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'reactions': reactions?.toMap(skipNulls: skipNulls),
      'next_offset': next_offset?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

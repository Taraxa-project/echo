import 'package:td_json_client/api/base.dart';


/// Represents a list of available reactions 
class AvailableReactions extends TdObject {
  String get tdType => 'availableReactions';

  String? extra;
  int? client_id;

  /// List of reactions
  vector<string>? reactions;

  AvailableReactions({
    this.extra,
    this.client_id,
    this.reactions,
  });

  AvailableReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['reactions']) {
      reactions = [];
      for (var someValue in map['reactions']) {
        reactions?.add(someValue);
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

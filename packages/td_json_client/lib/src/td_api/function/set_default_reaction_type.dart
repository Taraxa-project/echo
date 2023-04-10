import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/reaction_type.dart';

/// Changes type of default reaction for the current user
class SetDefaultReactionType extends TdFunction {
  String get tdType => 'setDefaultReactionType';
  String get tdReturnType => 'Ok';

  /// New type of the default reaction
  ReactionType? reaction_type;

  SetDefaultReactionType({
    super.extra,
    super.client_id,
    this.reaction_type,
  });

  SetDefaultReactionType.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['reaction_type'] != null) {
      reaction_type = TdApiMap.fromMap(map['reaction_type']) as ReactionType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reaction_type': reaction_type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

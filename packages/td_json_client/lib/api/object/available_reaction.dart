import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reaction_type.dart';


/// Represents an available reaction 
class AvailableReaction extends TdObject {
  String get tdType => 'availableReaction';


  /// Type of the reaction 
  ReactionType? type;

  /// True, if Telegram Premium is needed to send the reaction
  Bool? needs_premium;

  AvailableReaction({
    super.extra,
    super.client_id,
    this.type,
    this.needs_premium,
  });

  AvailableReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as ReactionType;
    }
    needs_premium = map['needs_premium'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'needs_premium': needs_premium?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

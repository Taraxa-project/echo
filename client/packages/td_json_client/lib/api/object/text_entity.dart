import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/text_entity_type.dart';


/// Represents a part of the text that needs to be formatted in some unusual way 
class TextEntity extends TdObject {
  String get tdType => 'textEntity';


  /// Offset of the entity, in UTF-16 code units 
  int32? offset;

  /// Length of the entity, in UTF-16 code units 
  int32? length;

  /// Type of the entity
  TextEntityType? type;

  TextEntity({
    super.extra,
    super.client_id,
    this.offset,
    this.length,
    this.type,
  });

  TextEntity.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    offset = map['offset'];
    length = map['length'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as TextEntityType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

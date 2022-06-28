import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/text_entity.dart';


/// Contains a list of text entities 
class TextEntities extends TdObject {
  String get tdType => 'textEntities';

  String? extra;
  int? client_id;

  /// List of text entities
  vector<TextEntity>? entities;

  TextEntities({
    this.extra,
    this.client_id,
    this.entities,
  });

  TextEntities.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['entities']) {
      entities = [];
      for (var someValue in map['entities']) {
        entities?.add(TdApiMap.fromMap(someValue) as TextEntity);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'entities': entities?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

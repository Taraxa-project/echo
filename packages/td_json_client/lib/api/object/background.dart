import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/document.dart';
import 'package:td_json_client/api/object/background_type.dart';

class Background extends TdObject {
  String get tdType => 'background';

  string? extra;
  int? client_id;
  int64? id;
  Bool? is_default;
  Bool? is_dark;
  string? name;
  Document? document;
  BackgroundType? type;

  Background({
    this.extra,
    this.client_id,
    this.id,
    this.is_default,
    this.is_dark,
    this.name,
    this.document,
    this.type,
  });

  Background.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    is_default = map['is_default'];
    is_dark = map['is_dark'];
    name = map['name'];
    document = TdApiMap.fromMap(map['document']) as Document;
    type = TdApiMap.fromMap(map['type']) as BackgroundType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'is_default': is_default?.toMap(skipNulls: skipNulls),
      'is_dark': is_dark?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'document': document?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

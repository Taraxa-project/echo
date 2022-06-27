import 'package:td_json_client/api/base.dart';

class Emojis extends TdObject {
  String get tdType => 'emojis';

  string? extra;
  int? client_id;
  vector<string>? emojis;

  Emojis({
    this.extra,
    this.client_id,
    this.emojis,
  });

  Emojis.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['emojis']) {
      emojis = [];
      for (var someValue in map['emojis']) {
        emojis?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

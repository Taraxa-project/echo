import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker.dart';


/// Represents a list of stickers 
class Stickers extends TdObject {
  String get tdType => 'stickers';


  /// List of stickers
  vector<Sticker>? stickers;

  Stickers({
    super.extra,
    super.client_id,
    this.stickers,
  });

  Stickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['stickers'] != null) {
      stickers = [];
      for (var someValue in map['stickers']) {
        if (someValue != null) {
          stickers?.add(TdApiMap.fromMap(someValue) as Sticker);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'stickers': stickers?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

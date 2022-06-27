import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_set_info.dart';

class StickerSets extends TdObject {
  String get tdType => 'stickerSets';

  string? extra;
  int? client_id;
  int32? total_count;
  vector<StickerSetInfo>? sets;

  StickerSets({
    this.extra,
    this.client_id,
    this.total_count,
    this.sets,
  });

  StickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['sets']) {
      sets = [];
      for (var someValue in map['sets']) {
        sets?.add(TdApiMap.fromMap(someValue) as StickerSetInfo);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'sets': sets?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

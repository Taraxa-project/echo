import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sticker_set_info.dart';

/// Represents a list of sticker sets
class StickerSets extends TdObject {
  String get tdType => 'stickerSets';

  /// Approximate total number of sticker sets found
  int32? total_count;

  /// List of sticker sets
  vector<StickerSetInfo>? sets;

  StickerSets({
    super.extra,
    super.client_id,
    this.total_count,
    this.sets,
  });

  StickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['sets'] != null) {
      sets = [];
      for (var someValue in map['sets']) {
        if (someValue != null) {
          sets?.add(TdApiMap.fromMap(someValue) as StickerSetInfo);
        }
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

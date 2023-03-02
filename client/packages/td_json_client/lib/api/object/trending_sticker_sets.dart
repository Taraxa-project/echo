import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_set_info.dart';


/// Represents a list of trending sticker sets 
class TrendingStickerSets extends TdObject {
  String get tdType => 'trendingStickerSets';


  /// Approximate total number of trending sticker sets 
  int32? total_count;

  /// List of trending sticker sets 
  vector<StickerSetInfo>? sets;

  /// True, if the list contains sticker sets with premium stickers
  Bool? is_premium;

  TrendingStickerSets({
    super.extra,
    super.client_id,
    this.total_count,
    this.sets,
    this.is_premium,
  });

  TrendingStickerSets.fromMap(Map<String, dynamic> map) {
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
    is_premium = map['is_premium'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'sets': sets?.toMap(skipNulls: skipNulls),
      'is_premium': is_premium?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

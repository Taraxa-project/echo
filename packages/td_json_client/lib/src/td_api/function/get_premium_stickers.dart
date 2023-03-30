import 'package:td_json_client/src/td_api/td.dart';

/// Returns premium stickers from regular sticker sets
class GetPremiumStickers extends TdFunction {
  String get tdType => 'getPremiumStickers';
  String get tdReturnType => 'Stickers';

  /// The maximum number of stickers to be returned; 0-100
  int32? limit;

  GetPremiumStickers({
    super.extra,
    super.client_id,
    this.limit,
  });

  GetPremiumStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

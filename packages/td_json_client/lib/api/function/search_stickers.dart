import 'package:td_json_client/api/base.dart';

class SearchStickers extends TdFunction {
  String get tdType => 'searchStickers';
  String get tdReturnType => 'Stickers';

  String? extra;
  int? client_id;
  string? emoji;
  int32? limit;

  SearchStickers({
    this.extra,
    this.client_id,
    this.emoji,
    this.limit,
  });

  SearchStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    emoji = map['emoji'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

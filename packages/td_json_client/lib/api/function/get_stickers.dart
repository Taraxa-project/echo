import 'package:td_json_client/api/base.dart';

class GetStickers extends TdFunction {
  String get tdType => 'getStickers';
  String get tdReturnType => 'Stickers';

  String? extra;
  int? client_id;
  string? emoji;
  int32? limit;

  GetStickers({
    this.extra,
    this.client_id,
    this.emoji,
    this.limit,
  });

  GetStickers.fromMap(Map<String, dynamic> map) {
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

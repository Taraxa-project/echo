import 'package:td_json_client/src/td_api/td.dart';

/// Returns a list of recently used stickers
class GetRecentStickers extends TdFunction {
  String get tdType => 'getRecentStickers';
  String get tdReturnType => 'Stickers';

  /// Pass true to return stickers and masks that were recently attached to photos or video files; pass false to return recently sent stickers
  Bool? is_attached;

  GetRecentStickers({
    super.extra,
    super.client_id,
    this.is_attached,
  });

  GetRecentStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_attached = map['is_attached'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_attached': is_attached?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

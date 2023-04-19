import 'package:td_json_client/src/td_api/td.dart';

/// Returns a suggested name for a new sticker set with a given title
class GetSuggestedStickerSetName extends TdFunction {
  String get tdType => 'getSuggestedStickerSetName';
  String get tdReturnType => 'Text';

  /// Sticker set title; 1-64 characters
  string? title;

  GetSuggestedStickerSetName({
    super.extra,
    super.client_id,
    this.title,
  });

  GetSuggestedStickerSetName.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

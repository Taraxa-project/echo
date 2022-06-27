import 'package:td_json_client/api/base.dart';

class GetSuggestedStickerSetName extends TdFunction {
  String get tdType => 'getSuggestedStickerSetName';
  String get tdReturnType => 'Text';

  string? extra;
  int? client_id;
  string? title;

  GetSuggestedStickerSetName({
    this.extra,
    this.client_id,
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

import 'package:td_json_client/api/base.dart';


/// Returns examples of premium stickers for demonstration purposes
class GetPremiumStickerExamples extends TdFunction {
  String get tdType => 'getPremiumStickerExamples';
  String get tdReturnType => 'Stickers';


  GetPremiumStickerExamples({
    super.extra,
    super.client_id,
  });

  GetPremiumStickerExamples.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

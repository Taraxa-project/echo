import 'package:td_json_client/api/base.dart';


/// Returns information about the current localization target. This is an offline request if only_local is true. Can be called before authorization 
class GetLocalizationTargetInfo extends TdFunction {
  String get tdType => 'getLocalizationTargetInfo';
  String get tdReturnType => 'LocalizationTargetInfo';


  /// If true, returns only locally available information without sending network requests
  Bool? only_local;

  GetLocalizationTargetInfo({
    super.extra,
    super.client_id,
    this.only_local,
  });

  GetLocalizationTargetInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    only_local = map['only_local'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'only_local': only_local?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

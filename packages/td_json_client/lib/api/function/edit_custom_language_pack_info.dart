import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/language_pack_info.dart';

class EditCustomLanguagePackInfo extends TdFunction {
  String get tdType => 'editCustomLanguagePackInfo';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  LanguagePackInfo? info;

  EditCustomLanguagePackInfo({
    this.extra,
    this.client_id,
    this.info,
  });

  EditCustomLanguagePackInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    info = TdApiMap.fromMap(map['info']) as LanguagePackInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'info': info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

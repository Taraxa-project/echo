import 'package:td_json_client/api/base.dart';

class SynchronizeLanguagePack extends TdFunction {
  String get tdType => 'synchronizeLanguagePack';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  string? language_pack_id;

  SynchronizeLanguagePack({
    this.extra,
    this.client_id,
    this.language_pack_id,
  });

  SynchronizeLanguagePack.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_pack_id = map['language_pack_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_pack_id': language_pack_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

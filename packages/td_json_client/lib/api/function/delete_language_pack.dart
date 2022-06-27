import 'package:td_json_client/api/base.dart';

class DeleteLanguagePack extends TdFunction {
  String get tdType => 'deleteLanguagePack';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? language_pack_id;

  DeleteLanguagePack({
    this.extra,
    this.client_id,
    this.language_pack_id,
  });

  DeleteLanguagePack.fromMap(Map<String, dynamic> map) {
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

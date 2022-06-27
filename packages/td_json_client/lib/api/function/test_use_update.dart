import 'package:td_json_client/api/base.dart';


/// Does nothing and ensures that the Update object is used; for testing only. This is an offline method. Can be called before authorization
class TestUseUpdate extends TdFunction {
  String get tdType => 'testUseUpdate';
  String get tdReturnType => 'Update';

  String? extra;
  int? client_id;

  TestUseUpdate({
    this.extra,
    this.client_id,
  });

  TestUseUpdate.fromMap(Map<String, dynamic> map) {
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

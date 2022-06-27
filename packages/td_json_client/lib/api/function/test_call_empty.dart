import 'package:td_json_client/api/base.dart';


/// Does nothing; for testing only. This is an offline method. Can be called before authorization
class TestCallEmpty extends TdFunction {
  String get tdType => 'testCallEmpty';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  TestCallEmpty({
    this.extra,
    this.client_id,
  });

  TestCallEmpty.fromMap(Map<String, dynamic> map) {
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

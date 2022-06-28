import 'package:td_json_client/api/base.dart';


/// Forces an updates.getDifference call to the Telegram servers; for testing only
class TestGetDifference extends TdFunction {
  String get tdType => 'testGetDifference';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  TestGetDifference({
    this.extra,
    this.client_id,
  });

  TestGetDifference.fromMap(Map<String, dynamic> map) {
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

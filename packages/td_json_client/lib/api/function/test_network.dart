import 'package:td_json_client/api/base.dart';


/// Sends a simple network request to the Telegram servers; for testing only. Can be called before authorization
class TestNetwork extends TdFunction {
  String get tdType => 'testNetwork';
  String get tdReturnType => 'Ok';


  TestNetwork({
    super.extra,
    super.client_id,
  });

  TestNetwork.fromMap(Map<String, dynamic> map) {
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

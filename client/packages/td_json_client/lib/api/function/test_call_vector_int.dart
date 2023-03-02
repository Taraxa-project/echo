import 'package:td_json_client/api/base.dart';


/// Returns the received vector of numbers; for testing only. This is an offline method. Can be called before authorization 
class TestCallVectorInt extends TdFunction {
  String get tdType => 'testCallVectorInt';
  String get tdReturnType => 'TestVectorInt';


  /// Vector of numbers to return
  vector<int32>? x;

  TestCallVectorInt({
    super.extra,
    super.client_id,
    this.x,
  });

  TestCallVectorInt.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['x'] != null) {
      x = [];
      for (var someValue in map['x']) {
        x?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'x': x?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

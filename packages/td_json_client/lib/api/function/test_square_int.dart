import 'package:td_json_client/api/base.dart';


/// Returns the squared received number; for testing only. This is an offline method. Can be called before authorization 
class TestSquareInt extends TdFunction {
  String get tdType => 'testSquareInt';
  String get tdReturnType => 'TestInt';


  /// Number to square
  int32? x;

  TestSquareInt({
    super.extra,
    super.client_id,
    this.x,
  });

  TestSquareInt.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    x = map['x'];
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

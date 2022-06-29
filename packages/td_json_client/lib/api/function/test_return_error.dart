import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/error.dart';


/// Returns the specified error and ensures that the Error object is used; for testing only. Can be called synchronously 
class TestReturnError extends TdFunction {
  String get tdType => 'testReturnError';
  String get tdReturnType => 'Error';

  String? extra;
  int? client_id;

  /// The error to be returned
  Error? error;

  TestReturnError({
    this.extra,
    this.client_id,
    this.error,
  });

  TestReturnError.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['error'] != null) {
      error = TdApiMap.fromMap(map['error']) as Error;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'error': error?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

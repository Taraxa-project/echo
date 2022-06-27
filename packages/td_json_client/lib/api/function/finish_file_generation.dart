import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/error.dart';

class FinishFileGeneration extends TdFunction {
  String get tdType => 'finishFileGeneration';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int64? generation_id;
  Error? error;

  FinishFileGeneration({
    this.extra,
    this.client_id,
    this.generation_id,
    this.error,
  });

  FinishFileGeneration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    generation_id = map['generation_id'];
    error = TdApiMap.fromMap(map['error']) as Error;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'generation_id': generation_id?.toMap(skipNulls: skipNulls),
      'error': error?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/error.dart';


/// Finishes the file generation
class FinishFileGeneration extends TdFunction {
  String get tdType => 'finishFileGeneration';
  String get tdReturnType => 'Ok';


  /// The identifier of the generation process
  int64? generation_id;

  /// If passed, the file generation has failed and must be terminated; pass null if the file generation succeeded
  Error? error;

  FinishFileGeneration({
    super.extra,
    super.client_id,
    this.generation_id,
    this.error,
  });

  FinishFileGeneration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    generation_id = map['generation_id'];
    if (map['error'] != null) {
      error = TdApiMap.fromMap(map['error']) as Error;
    }
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

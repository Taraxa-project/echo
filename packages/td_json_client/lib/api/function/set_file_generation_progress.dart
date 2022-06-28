import 'package:td_json_client/api/base.dart';


/// Informs TDLib on a file generation progress
class SetFileGenerationProgress extends TdFunction {
  String get tdType => 'setFileGenerationProgress';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The identifier of the generation process
  int64? generation_id;

  /// Expected size of the generated file, in bytes; 0 if unknown
  int32? expected_size;

  /// The number of bytes already generated
  int32? local_prefix_size;

  SetFileGenerationProgress({
    this.extra,
    this.client_id,
    this.generation_id,
    this.expected_size,
    this.local_prefix_size,
  });

  SetFileGenerationProgress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    generation_id = map['generation_id'];
    expected_size = map['expected_size'];
    local_prefix_size = map['local_prefix_size'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'generation_id': generation_id?.toMap(skipNulls: skipNulls),
      'expected_size': expected_size?.toMap(skipNulls: skipNulls),
      'local_prefix_size': local_prefix_size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

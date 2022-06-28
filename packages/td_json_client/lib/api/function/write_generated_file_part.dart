import 'package:td_json_client/api/base.dart';


/// Writes a part of a generated file. This method is intended to be used only if the application has no direct access to TDLib's file system, because it is usually slower than a direct write to the destination file
class WriteGeneratedFilePart extends TdFunction {
  String get tdType => 'writeGeneratedFilePart';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The identifier of the generation process 
  int64? generation_id;

  /// The offset from which to write the data to the file 
  int32? offset;

  /// The data to write
  bytes? data;

  WriteGeneratedFilePart({
    this.extra,
    this.client_id,
    this.generation_id,
    this.offset,
    this.data,
  });

  WriteGeneratedFilePart.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    generation_id = map['generation_id'];
    offset = map['offset'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'generation_id': generation_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

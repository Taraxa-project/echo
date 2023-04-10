import 'package:td_json_client/src/td_api/td.dart';

/// Returns the extension of a file, guessed by its MIME type. Returns an empty string on failure. Can be called synchronously
class GetFileExtension extends TdFunction {
  String get tdType => 'getFileExtension';
  String get tdReturnType => 'Text';

  /// The MIME type of the file
  string? mime_type;

  GetFileExtension({
    super.extra,
    super.client_id,
    this.mime_type,
  });

  GetFileExtension.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    mime_type = map['mime_type'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Changes pause state of a file in the file download list
class ToggleDownloadIsPaused extends TdFunction {
  String get tdType => 'toggleDownloadIsPaused';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Identifier of the downloaded file
  int32? file_id;

  /// Pass true if the download is paused
  Bool? is_paused;

  ToggleDownloadIsPaused({
    this.extra,
    this.client_id,
    this.file_id,
    this.is_paused,
  });

  ToggleDownloadIsPaused.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    is_paused = map['is_paused'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'is_paused': is_paused?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

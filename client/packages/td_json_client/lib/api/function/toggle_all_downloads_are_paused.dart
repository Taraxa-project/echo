import 'package:td_json_client/api/base.dart';


/// Changes pause state of all files in the file download list 
class ToggleAllDownloadsArePaused extends TdFunction {
  String get tdType => 'toggleAllDownloadsArePaused';
  String get tdReturnType => 'Ok';


  /// Pass true to pause all downloads; pass false to unpause them
  Bool? are_paused;

  ToggleAllDownloadsArePaused({
    super.extra,
    super.client_id,
    this.are_paused,
  });

  ToggleAllDownloadsArePaused.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    are_paused = map['are_paused'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'are_paused': are_paused?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/auto_download_settings.dart';

class AutoDownloadSettingsPresets extends TdObject {
  String get tdType => 'autoDownloadSettingsPresets';

  string? extra;
  int? client_id;
  AutoDownloadSettings? low;
  AutoDownloadSettings? medium;
  AutoDownloadSettings? high;

  AutoDownloadSettingsPresets({
    this.extra,
    this.client_id,
    this.low,
    this.medium,
    this.high,
  });

  AutoDownloadSettingsPresets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    low = TdApiMap.fromMap(map['low']) as AutoDownloadSettings;
    medium = TdApiMap.fromMap(map['medium']) as AutoDownloadSettings;
    high = TdApiMap.fromMap(map['high']) as AutoDownloadSettings;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'low': low?.toMap(skipNulls: skipNulls),
      'medium': medium?.toMap(skipNulls: skipNulls),
      'high': high?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

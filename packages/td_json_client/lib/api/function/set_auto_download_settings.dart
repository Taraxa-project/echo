import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/auto_download_settings.dart';
import 'package:td_json_client/api/object/network_type.dart';

class SetAutoDownloadSettings extends TdFunction {
  String get tdType => 'setAutoDownloadSettings';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  AutoDownloadSettings? settings;
  NetworkType? type;

  SetAutoDownloadSettings({
    this.extra,
    this.client_id,
    this.settings,
    this.type,
  });

  SetAutoDownloadSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    settings = TdApiMap.fromMap(map['settings']) as AutoDownloadSettings;
    type = TdApiMap.fromMap(map['type']) as NetworkType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'settings': settings?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

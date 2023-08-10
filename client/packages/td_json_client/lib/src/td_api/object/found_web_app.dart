import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/web_app.dart';

/// Contains information about a Web App found by its short name
class FoundWebApp extends TdObject {
  String get tdType => 'foundWebApp';

  /// The Web App
  WebApp? web_app;

  /// True, if the user must be asked for the permission to the bot to send them messages
  Bool? request_write_access;

  /// True, if there is no need to show an ordinary open URL confirmation before opening the Web App. The field must be ignored and confirmation must be shown anyway if the Web App link was hidden
  Bool? skip_confirmation;

  FoundWebApp({
    super.extra,
    super.client_id,
    this.web_app,
    this.request_write_access,
    this.skip_confirmation,
  });

  FoundWebApp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['web_app'] != null) {
      web_app = TdApiMap.fromMap(map['web_app']) as WebApp;
    }
    request_write_access = map['request_write_access'];
    skip_confirmation = map['skip_confirmation'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'web_app': web_app?.toMap(skipNulls: skipNulls),
      'request_write_access': request_write_access?.toMap(skipNulls: skipNulls),
      'skip_confirmation': skip_confirmation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

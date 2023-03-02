import 'package:td_json_client/api/base.dart';


/// Informs TDLib that a previously opened Web App was closed 
class CloseWebApp extends TdFunction {
  String get tdType => 'closeWebApp';
  String get tdReturnType => 'Ok';


  /// Identifier of Web App launch, received from openWebApp
  int64? web_app_launch_id;

  CloseWebApp({
    super.extra,
    super.client_id,
    this.web_app_launch_id,
  });

  CloseWebApp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    web_app_launch_id = map['web_app_launch_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'web_app_launch_id': web_app_launch_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

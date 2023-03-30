import 'package:td_json_client/src/td_api/td.dart';

/// Confirms QR code authentication on another device. Returns created session on success
class ConfirmQrCodeAuthentication extends TdFunction {
  String get tdType => 'confirmQrCodeAuthentication';
  String get tdReturnType => 'Session';

  /// A link from a QR code. The link must be scanned by the in-app camera
  string? link;

  ConfirmQrCodeAuthentication({
    super.extra,
    super.client_id,
    this.link,
  });

  ConfirmQrCodeAuthentication.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    link = map['link'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

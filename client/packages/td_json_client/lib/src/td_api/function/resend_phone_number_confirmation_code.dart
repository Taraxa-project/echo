import 'package:td_json_client/src/td_api/td.dart';

/// Resends phone number confirmation code
class ResendPhoneNumberConfirmationCode extends TdFunction {
  String get tdType => 'resendPhoneNumberConfirmationCode';
  String get tdReturnType => 'AuthenticationCodeInfo';

  ResendPhoneNumberConfirmationCode({
    super.extra,
    super.client_id,
  });

  ResendPhoneNumberConfirmationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

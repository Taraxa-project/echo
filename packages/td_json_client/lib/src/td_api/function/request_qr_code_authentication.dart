import 'package:td_json_client/src/td_api/td.dart';

/// Requests QR code authentication by scanning a QR code on another logged in device. Works only when the current authorization state is authorizationStateWaitPhoneNumber,
/// or if there is no pending authentication query and the current authorization state is authorizationStateWaitEmailAddress, authorizationStateWaitEmailCode, authorizationStateWaitCode, authorizationStateWaitRegistration, or authorizationStateWaitPassword
class RequestQrCodeAuthentication extends TdFunction {
  String get tdType => 'requestQrCodeAuthentication';
  String get tdReturnType => 'Ok';

  /// List of user identifiers of other users currently using the application
  vector<int53>? other_user_ids;

  RequestQrCodeAuthentication({
    super.extra,
    super.client_id,
    this.other_user_ids,
  });

  RequestQrCodeAuthentication.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['other_user_ids'] != null) {
      other_user_ids = [];
      for (var someValue in map['other_user_ids']) {
        other_user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'other_user_ids': other_user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

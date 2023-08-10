import 'package:td_json_client/src/td_api/td.dart';

/// Describes reset state of a email address
abstract class EmailAddressResetState extends TdObject {
  EmailAddressResetState({super.extra, super.client_id});
}

/// Email address can be reset after the given period. Call resetAuthenticationEmailAddress to reset it and allow the user to authorize with a code sent to the user's phone number
class EmailAddressResetStateAvailable extends EmailAddressResetState {
  String get tdType => 'emailAddressResetStateAvailable';

  /// Time required to wait before the email address can be reset; 0 if the user is subscribed to Telegram Premium
  int32? wait_period;

  EmailAddressResetStateAvailable({
    super.extra,
    super.client_id,
    this.wait_period,
  });

  EmailAddressResetStateAvailable.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    wait_period = map['wait_period'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'wait_period': wait_period?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Email address reset has already been requested. Call resetAuthenticationEmailAddress to check whether immediate reset is possible
class EmailAddressResetStatePending extends EmailAddressResetState {
  String get tdType => 'emailAddressResetStatePending';

  /// Left time before the email address will be reset, in seconds. updateAuthorizationState is not sent when this field changes
  int32? reset_in;

  EmailAddressResetStatePending({
    super.extra,
    super.client_id,
    this.reset_in,
  });

  EmailAddressResetStatePending.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reset_in = map['reset_in'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reset_in': reset_in?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

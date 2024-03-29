import 'package:td_json_client/src/td_api/td.dart';

/// Provides information about the method by which an authentication code is delivered to the user
abstract class AuthenticationCodeType extends TdObject {
  AuthenticationCodeType({super.extra, super.client_id});
}

/// An authentication code is delivered via a private Telegram message, which can be viewed from another active session
class AuthenticationCodeTypeTelegramMessage extends AuthenticationCodeType {
  String get tdType => 'authenticationCodeTypeTelegramMessage';

  /// Length of the code
  int32? length;

  AuthenticationCodeTypeTelegramMessage({
    super.extra,
    super.client_id,
    this.length,
  });

  AuthenticationCodeTypeTelegramMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication code is delivered via an SMS message to the specified phone number; applications may not receive this type of code
class AuthenticationCodeTypeSms extends AuthenticationCodeType {
  String get tdType => 'authenticationCodeTypeSms';

  /// Length of the code
  int32? length;

  AuthenticationCodeTypeSms({
    super.extra,
    super.client_id,
    this.length,
  });

  AuthenticationCodeTypeSms.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication code is delivered via a phone call to the specified phone number
class AuthenticationCodeTypeCall extends AuthenticationCodeType {
  String get tdType => 'authenticationCodeTypeCall';

  /// Length of the code
  int32? length;

  AuthenticationCodeTypeCall({
    super.extra,
    super.client_id,
    this.length,
  });

  AuthenticationCodeTypeCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication code is delivered by an immediately canceled call to the specified phone number. The phone number that calls is the code that must be entered automatically
class AuthenticationCodeTypeFlashCall extends AuthenticationCodeType {
  String get tdType => 'authenticationCodeTypeFlashCall';

  /// Pattern of the phone number from which the call will be made
  string? pattern;

  AuthenticationCodeTypeFlashCall({
    super.extra,
    super.client_id,
    this.pattern,
  });

  AuthenticationCodeTypeFlashCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    pattern = map['pattern'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'pattern': pattern?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication code is delivered by an immediately canceled call to the specified phone number. The last digits of the phone number that calls are the code that must be entered manually by the user
class AuthenticationCodeTypeMissedCall extends AuthenticationCodeType {
  String get tdType => 'authenticationCodeTypeMissedCall';

  /// Prefix of the phone number from which the call will be made
  string? phone_number_prefix;

  /// Number of digits in the code, excluding the prefix
  int32? length;

  AuthenticationCodeTypeMissedCall({
    super.extra,
    super.client_id,
    this.phone_number_prefix,
    this.length,
  });

  AuthenticationCodeTypeMissedCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number_prefix = map['phone_number_prefix'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'phone_number_prefix': phone_number_prefix?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication code is delivered to https://fragment.com. The user must be logged in there via a wallet owning the phone number's NFT
class AuthenticationCodeTypeFragment extends AuthenticationCodeType {
  String get tdType => 'authenticationCodeTypeFragment';

  /// URL to open to receive the code
  string? url;

  /// Length of the code
  int32? length;

  AuthenticationCodeTypeFragment({
    super.extra,
    super.client_id,
    this.url,
    this.length,
  });

  AuthenticationCodeTypeFragment.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication code is delivered via Firebase Authentication to the official Android application
class AuthenticationCodeTypeFirebaseAndroid extends AuthenticationCodeType {
  String get tdType => 'authenticationCodeTypeFirebaseAndroid';

  /// Nonce to pass to the SafetyNet Attestation API
  bytes? nonce;

  /// Length of the code
  int32? length;

  AuthenticationCodeTypeFirebaseAndroid({
    super.extra,
    super.client_id,
    this.nonce,
    this.length,
  });

  AuthenticationCodeTypeFirebaseAndroid.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    nonce = map['nonce'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'nonce': nonce?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication code is delivered via Firebase Authentication to the official iOS application
class AuthenticationCodeTypeFirebaseIos extends AuthenticationCodeType {
  String get tdType => 'authenticationCodeTypeFirebaseIos';

  /// Receipt of successful application token validation to compare with receipt from push notification
  string? receipt;

  /// Time after the next authentication method is supposed to be used if verification push notification isn't received, in seconds
  int32? push_timeout;

  /// Length of the code
  int32? length;

  AuthenticationCodeTypeFirebaseIos({
    super.extra,
    super.client_id,
    this.receipt,
    this.push_timeout,
    this.length,
  });

  AuthenticationCodeTypeFirebaseIos.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    receipt = map['receipt'];
    push_timeout = map['push_timeout'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'receipt': receipt?.toMap(skipNulls: skipNulls),
      'push_timeout': push_timeout?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

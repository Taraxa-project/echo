import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/email_address_authentication_code_info.dart';
import 'package:td_json_client/src/td_api/object/authentication_code_info.dart';
import 'package:td_json_client/src/td_api/object/terms_of_service.dart';

/// Represents the current authorization state of the TDLib client
abstract class AuthorizationState extends TdObject {
  AuthorizationState({super.extra, super.client_id});
}

/// Initializetion parameters are needed. Call setTdlibParameters to provide them
class AuthorizationStateWaitTdlibParameters extends AuthorizationState {
  String get tdType => 'authorizationStateWaitTdlibParameters';

  AuthorizationStateWaitTdlibParameters({
    super.extra,
    super.client_id,
  });

  AuthorizationStateWaitTdlibParameters.fromMap(Map<String, dynamic> map) {
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

/// TDLib needs the user's phone number to authorize. Call setAuthenticationPhoneNumber to provide the phone number, or use requestQrCodeAuthentication or checkAuthenticationBotToken for other authentication options
class AuthorizationStateWaitPhoneNumber extends AuthorizationState {
  String get tdType => 'authorizationStateWaitPhoneNumber';

  AuthorizationStateWaitPhoneNumber({
    super.extra,
    super.client_id,
  });

  AuthorizationStateWaitPhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// TDLib needs the user's email address to authorize. Call setAuthenticationEmailAddress to provide the email address, or directly call checkAuthenticationEmailCode with Apple ID/Google ID token if allowed
class AuthorizationStateWaitEmailAddress extends AuthorizationState {
  String get tdType => 'authorizationStateWaitEmailAddress';

  /// True, if authorization through Apple ID is allowed
  Bool? allow_apple_id;

  /// True, if authorization through Google ID is allowed
  Bool? allow_google_id;

  AuthorizationStateWaitEmailAddress({
    super.extra,
    super.client_id,
    this.allow_apple_id,
    this.allow_google_id,
  });

  AuthorizationStateWaitEmailAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    allow_apple_id = map['allow_apple_id'];
    allow_google_id = map['allow_google_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'allow_apple_id': allow_apple_id?.toMap(skipNulls: skipNulls),
      'allow_google_id': allow_google_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// TDLib needs the user's authentication code sent to an email address to authorize. Call checkAuthenticationEmailCode to provide the code
class AuthorizationStateWaitEmailCode extends AuthorizationState {
  String get tdType => 'authorizationStateWaitEmailCode';

  /// True, if authorization through Apple ID is allowed
  Bool? allow_apple_id;

  /// True, if authorization through Google ID is allowed
  Bool? allow_google_id;

  /// Information about the sent authentication code
  EmailAddressAuthenticationCodeInfo? code_info;

  /// Point in time (Unix timestamp) when the user will be able to authorize with a code sent to the user's phone number; 0 if unknown
  int32? next_phone_number_authorization_date;

  AuthorizationStateWaitEmailCode({
    super.extra,
    super.client_id,
    this.allow_apple_id,
    this.allow_google_id,
    this.code_info,
    this.next_phone_number_authorization_date,
  });

  AuthorizationStateWaitEmailCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    allow_apple_id = map['allow_apple_id'];
    allow_google_id = map['allow_google_id'];
    if (map['code_info'] != null) {
      code_info = TdApiMap.fromMap(map['code_info'])
          as EmailAddressAuthenticationCodeInfo;
    }
    next_phone_number_authorization_date =
        map['next_phone_number_authorization_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'allow_apple_id': allow_apple_id?.toMap(skipNulls: skipNulls),
      'allow_google_id': allow_google_id?.toMap(skipNulls: skipNulls),
      'code_info': code_info?.toMap(skipNulls: skipNulls),
      'next_phone_number_authorization_date':
          next_phone_number_authorization_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// TDLib needs the user's authentication code to authorize. Call checkAuthenticationCode to check the code
class AuthorizationStateWaitCode extends AuthorizationState {
  String get tdType => 'authorizationStateWaitCode';

  /// Information about the authorization code that was sent
  AuthenticationCodeInfo? code_info;

  AuthorizationStateWaitCode({
    super.extra,
    super.client_id,
    this.code_info,
  });

  AuthorizationStateWaitCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['code_info'] != null) {
      code_info = TdApiMap.fromMap(map['code_info']) as AuthenticationCodeInfo;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'code_info': code_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user needs to confirm authorization on another logged in device by scanning a QR code with the provided link
class AuthorizationStateWaitOtherDeviceConfirmation extends AuthorizationState {
  String get tdType => 'authorizationStateWaitOtherDeviceConfirmation';

  /// A tg:// URL for the QR code. The link will be updated frequently
  string? link;

  AuthorizationStateWaitOtherDeviceConfirmation({
    super.extra,
    super.client_id,
    this.link,
  });

  AuthorizationStateWaitOtherDeviceConfirmation.fromMap(
      Map<String, dynamic> map) {
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

/// The user is unregistered and need to accept terms of service and enter their first name and last name to finish registration. Call registerUser to accept the terms of service and provide the data
class AuthorizationStateWaitRegistration extends AuthorizationState {
  String get tdType => 'authorizationStateWaitRegistration';

  /// Telegram terms of service
  TermsOfService? terms_of_service;

  AuthorizationStateWaitRegistration({
    super.extra,
    super.client_id,
    this.terms_of_service,
  });

  AuthorizationStateWaitRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['terms_of_service'] != null) {
      terms_of_service =
          TdApiMap.fromMap(map['terms_of_service']) as TermsOfService;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'terms_of_service': terms_of_service?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user has been authorized, but needs to enter a 2-step verification password to start using the application.
/// Call checkAuthenticationPassword to provide the password, or requestAuthenticationPasswordRecovery to recover the password, or deleteAccount to delete the account after a week
class AuthorizationStateWaitPassword extends AuthorizationState {
  String get tdType => 'authorizationStateWaitPassword';

  /// Hint for the password; may be empty
  string? password_hint;

  /// True, if a recovery email address has been set up
  Bool? has_recovery_email_address;

  /// Pattern of the email address to which the recovery email was sent; empty until a recovery email has been sent
  string? recovery_email_address_pattern;

  AuthorizationStateWaitPassword({
    super.extra,
    super.client_id,
    this.password_hint,
    this.has_recovery_email_address,
    this.recovery_email_address_pattern,
  });

  AuthorizationStateWaitPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    password_hint = map['password_hint'];
    has_recovery_email_address = map['has_recovery_email_address'];
    recovery_email_address_pattern = map['recovery_email_address_pattern'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'password_hint': password_hint?.toMap(skipNulls: skipNulls),
      'has_recovery_email_address':
          has_recovery_email_address?.toMap(skipNulls: skipNulls),
      'recovery_email_address_pattern':
          recovery_email_address_pattern?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user has been successfully authorized. TDLib is now ready to answer general requests
class AuthorizationStateReady extends AuthorizationState {
  String get tdType => 'authorizationStateReady';

  AuthorizationStateReady({
    super.extra,
    super.client_id,
  });

  AuthorizationStateReady.fromMap(Map<String, dynamic> map) {
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

/// The user is currently logging out
class AuthorizationStateLoggingOut extends AuthorizationState {
  String get tdType => 'authorizationStateLoggingOut';

  AuthorizationStateLoggingOut({
    super.extra,
    super.client_id,
  });

  AuthorizationStateLoggingOut.fromMap(Map<String, dynamic> map) {
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

/// TDLib is closing, all subsequent queries will be answered with the error 500. Note that closing TDLib can take a while. All resources will be freed only after authorizationStateClosed has been received
class AuthorizationStateClosing extends AuthorizationState {
  String get tdType => 'authorizationStateClosing';

  AuthorizationStateClosing({
    super.extra,
    super.client_id,
  });

  AuthorizationStateClosing.fromMap(Map<String, dynamic> map) {
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

/// TDLib client is in its final state. All databases are closed and all resources are released. No other updates will be received after this. All queries will be responded to
/// with error code 500. To continue working, one must create a new instance of the TDLib client
class AuthorizationStateClosed extends AuthorizationState {
  String get tdType => 'authorizationStateClosed';

  AuthorizationStateClosed({
    super.extra,
    super.client_id,
  });

  AuthorizationStateClosed.fromMap(Map<String, dynamic> map) {
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

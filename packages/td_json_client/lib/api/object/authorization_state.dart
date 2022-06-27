import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/authentication_code_info.dart';
import 'package:td_json_client/api/object/terms_of_service.dart';

abstract class AuthorizationState extends TdObject {}

class AuthorizationStateWaitTdlibParameters extends AuthorizationState {
  String get tdType => 'authorizationStateWaitTdlibParameters';

  string? extra;
  int? client_id;

  AuthorizationStateWaitTdlibParameters({
    this.extra,
    this.client_id,
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
class AuthorizationStateWaitEncryptionKey extends AuthorizationState {
  String get tdType => 'authorizationStateWaitEncryptionKey';

  string? extra;
  int? client_id;
  Bool? is_encrypted;

  AuthorizationStateWaitEncryptionKey({
    this.extra,
    this.client_id,
    this.is_encrypted,
  });

  AuthorizationStateWaitEncryptionKey.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_encrypted = map['is_encrypted'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_encrypted': is_encrypted?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class AuthorizationStateWaitPhoneNumber extends AuthorizationState {
  String get tdType => 'authorizationStateWaitPhoneNumber';

  string? extra;
  int? client_id;

  AuthorizationStateWaitPhoneNumber({
    this.extra,
    this.client_id,
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
class AuthorizationStateWaitCode extends AuthorizationState {
  String get tdType => 'authorizationStateWaitCode';

  string? extra;
  int? client_id;
  AuthenticationCodeInfo? code_info;

  AuthorizationStateWaitCode({
    this.extra,
    this.client_id,
    this.code_info,
  });

  AuthorizationStateWaitCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    code_info = TdApiMap.fromMap(map['code_info']) as AuthenticationCodeInfo;
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
class AuthorizationStateWaitOtherDeviceConfirmation extends AuthorizationState {
  String get tdType => 'authorizationStateWaitOtherDeviceConfirmation';

  string? extra;
  int? client_id;
  string? link;

  AuthorizationStateWaitOtherDeviceConfirmation({
    this.extra,
    this.client_id,
    this.link,
  });

  AuthorizationStateWaitOtherDeviceConfirmation.fromMap(Map<String, dynamic> map) {
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
class AuthorizationStateWaitRegistration extends AuthorizationState {
  String get tdType => 'authorizationStateWaitRegistration';

  string? extra;
  int? client_id;
  TermsOfService? terms_of_service;

  AuthorizationStateWaitRegistration({
    this.extra,
    this.client_id,
    this.terms_of_service,
  });

  AuthorizationStateWaitRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    terms_of_service = TdApiMap.fromMap(map['terms_of_service']) as TermsOfService;
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
class AuthorizationStateWaitPassword extends AuthorizationState {
  String get tdType => 'authorizationStateWaitPassword';

  string? extra;
  int? client_id;
  string? password_hint;
  Bool? has_recovery_email_address;
  string? recovery_email_address_pattern;

  AuthorizationStateWaitPassword({
    this.extra,
    this.client_id,
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
      'has_recovery_email_address': has_recovery_email_address?.toMap(skipNulls: skipNulls),
      'recovery_email_address_pattern': recovery_email_address_pattern?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class AuthorizationStateReady extends AuthorizationState {
  String get tdType => 'authorizationStateReady';

  string? extra;
  int? client_id;

  AuthorizationStateReady({
    this.extra,
    this.client_id,
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
class AuthorizationStateLoggingOut extends AuthorizationState {
  String get tdType => 'authorizationStateLoggingOut';

  string? extra;
  int? client_id;

  AuthorizationStateLoggingOut({
    this.extra,
    this.client_id,
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
class AuthorizationStateClosing extends AuthorizationState {
  String get tdType => 'authorizationStateClosing';

  string? extra;
  int? client_id;

  AuthorizationStateClosing({
    this.extra,
    this.client_id,
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
class AuthorizationStateClosed extends AuthorizationState {
  String get tdType => 'authorizationStateClosed';

  string? extra;
  int? client_id;

  AuthorizationStateClosed({
    this.extra,
    this.client_id,
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

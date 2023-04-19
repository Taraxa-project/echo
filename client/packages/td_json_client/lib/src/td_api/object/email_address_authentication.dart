import 'package:td_json_client/src/td_api/td.dart';

/// Contains authentication data for a email address
abstract class EmailAddressAuthentication extends TdObject {
  EmailAddressAuthentication({super.extra, super.client_id});
}

/// An authentication code delivered to a user's email address
class EmailAddressAuthenticationCode extends EmailAddressAuthentication {
  String get tdType => 'emailAddressAuthenticationCode';

  /// The code
  string? code;

  EmailAddressAuthenticationCode({
    super.extra,
    super.client_id,
    this.code,
  });

  EmailAddressAuthenticationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    code = map['code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'code': code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication token received through Apple ID
class EmailAddressAuthenticationAppleId extends EmailAddressAuthentication {
  String get tdType => 'emailAddressAuthenticationAppleId';

  /// The token
  string? token;

  EmailAddressAuthenticationAppleId({
    super.extra,
    super.client_id,
    this.token,
  });

  EmailAddressAuthenticationAppleId.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An authentication token received through Google ID
class EmailAddressAuthenticationGoogleId extends EmailAddressAuthentication {
  String get tdType => 'emailAddressAuthenticationGoogleId';

  /// The token
  string? token;

  EmailAddressAuthenticationGoogleId({
    super.extra,
    super.client_id,
    this.token,
  });

  EmailAddressAuthenticationGoogleId.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

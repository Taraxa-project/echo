import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about the payment method chosen by the user
abstract class InputCredentials extends TdObject {
  InputCredentials({super.extra, super.client_id});
}

/// Applies if a user chooses some previously saved payment credentials. To use their previously saved credentials, the user must have a valid temporary password
class InputCredentialsSaved extends InputCredentials {
  String get tdType => 'inputCredentialsSaved';

  /// Identifier of the saved credentials
  string? saved_credentials_id;

  InputCredentialsSaved({
    super.extra,
    super.client_id,
    this.saved_credentials_id,
  });

  InputCredentialsSaved.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    saved_credentials_id = map['saved_credentials_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'saved_credentials_id': saved_credentials_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Applies if a user enters new credentials on a payment provider website
class InputCredentialsNew extends InputCredentials {
  String get tdType => 'inputCredentialsNew';

  /// JSON-encoded data with the credential identifier from the payment provider
  string? data;

  /// True, if the credential identifier can be saved on the server side
  Bool? allow_save;

  InputCredentialsNew({
    super.extra,
    super.client_id,
    this.data,
    this.allow_save,
  });

  InputCredentialsNew.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    data = map['data'];
    allow_save = map['allow_save'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
      'allow_save': allow_save?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Applies if a user enters new credentials using Apple Pay
class InputCredentialsApplePay extends InputCredentials {
  String get tdType => 'inputCredentialsApplePay';

  /// JSON-encoded data with the credential identifier
  string? data;

  InputCredentialsApplePay({
    super.extra,
    super.client_id,
    this.data,
  });

  InputCredentialsApplePay.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Applies if a user enters new credentials using Google Pay
class InputCredentialsGooglePay extends InputCredentials {
  String get tdType => 'inputCredentialsGooglePay';

  /// JSON-encoded data with the credential identifier
  string? data;

  InputCredentialsGooglePay({
    super.extra,
    super.client_id,
    this.data,
  });

  InputCredentialsGooglePay.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

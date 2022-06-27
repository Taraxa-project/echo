import 'package:td_json_client/api/base.dart';

abstract class InputCredentials extends TdObject {}

class InputCredentialsSaved extends InputCredentials {
  String get tdType => 'inputCredentialsSaved';

  String? extra;
  int? client_id;
  string? saved_credentials_id;

  InputCredentialsSaved({
    this.extra,
    this.client_id,
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
class InputCredentialsNew extends InputCredentials {
  String get tdType => 'inputCredentialsNew';

  String? extra;
  int? client_id;
  string? data;
  Bool? allow_save;

  InputCredentialsNew({
    this.extra,
    this.client_id,
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
class InputCredentialsApplePay extends InputCredentials {
  String get tdType => 'inputCredentialsApplePay';

  String? extra;
  int? client_id;
  string? data;

  InputCredentialsApplePay({
    this.extra,
    this.client_id,
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
class InputCredentialsGooglePay extends InputCredentials {
  String get tdType => 'inputCredentialsGooglePay';

  String? extra;
  int? client_id;
  string? data;

  InputCredentialsGooglePay({
    this.extra,
    this.client_id,
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

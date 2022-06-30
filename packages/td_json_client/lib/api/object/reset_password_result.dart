import 'package:td_json_client/api/base.dart';

/// Represents result of 2-step verification password reset
abstract class ResetPasswordResult extends TdObject {
  ResetPasswordResult({super.extra, super.client_id});
}


/// The password was reset
class ResetPasswordResultOk extends ResetPasswordResult {
  String get tdType => 'resetPasswordResultOk';


  ResetPasswordResultOk({
    super.extra,
    super.client_id,
  });

  ResetPasswordResultOk.fromMap(Map<String, dynamic> map) {
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

/// The password reset request is pending 
class ResetPasswordResultPending extends ResetPasswordResult {
  String get tdType => 'resetPasswordResultPending';


  /// Point in time (Unix timestamp) after which the password can be reset immediately using resetPassword
  int32? pending_reset_date;

  ResetPasswordResultPending({
    super.extra,
    super.client_id,
    this.pending_reset_date,
  });

  ResetPasswordResultPending.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    pending_reset_date = map['pending_reset_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'pending_reset_date': pending_reset_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The password reset request was declined 
class ResetPasswordResultDeclined extends ResetPasswordResult {
  String get tdType => 'resetPasswordResultDeclined';


  /// Point in time (Unix timestamp) when the password reset can be retried
  int32? retry_date;

  ResetPasswordResultDeclined({
    super.extra,
    super.client_id,
    this.retry_date,
  });

  ResetPasswordResultDeclined.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    retry_date = map['retry_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'retry_date': retry_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

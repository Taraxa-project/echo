import 'package:td_json_client/api/base.dart';

abstract class ResetPasswordResult extends TdObject {}

class ResetPasswordResultOk extends ResetPasswordResult {
  String get tdType => 'resetPasswordResultOk';

  String? extra;
  int? client_id;

  ResetPasswordResultOk({
    this.extra,
    this.client_id,
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
class ResetPasswordResultPending extends ResetPasswordResult {
  String get tdType => 'resetPasswordResultPending';

  String? extra;
  int? client_id;
  int32? pending_reset_date;

  ResetPasswordResultPending({
    this.extra,
    this.client_id,
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
class ResetPasswordResultDeclined extends ResetPasswordResult {
  String get tdType => 'resetPasswordResultDeclined';

  String? extra;
  int? client_id;
  int32? retry_date;

  ResetPasswordResultDeclined({
    this.extra,
    this.client_id,
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

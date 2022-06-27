import 'package:td_json_client/api/base.dart';

class Session extends TdObject {
  String get tdType => 'session';

  string? extra;
  int? client_id;
  int64? id;
  Bool? is_current;
  Bool? is_password_pending;
  Bool? can_accept_secret_chats;
  Bool? can_accept_calls;
  int32? api_id;
  string? application_name;
  string? application_version;
  Bool? is_official_application;
  string? device_model;
  string? platform;
  string? system_version;
  int32? log_in_date;
  int32? last_active_date;
  string? ip;
  string? country;
  string? region;

  Session({
    this.extra,
    this.client_id,
    this.id,
    this.is_current,
    this.is_password_pending,
    this.can_accept_secret_chats,
    this.can_accept_calls,
    this.api_id,
    this.application_name,
    this.application_version,
    this.is_official_application,
    this.device_model,
    this.platform,
    this.system_version,
    this.log_in_date,
    this.last_active_date,
    this.ip,
    this.country,
    this.region,
  });

  Session.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    is_current = map['is_current'];
    is_password_pending = map['is_password_pending'];
    can_accept_secret_chats = map['can_accept_secret_chats'];
    can_accept_calls = map['can_accept_calls'];
    api_id = map['api_id'];
    application_name = map['application_name'];
    application_version = map['application_version'];
    is_official_application = map['is_official_application'];
    device_model = map['device_model'];
    platform = map['platform'];
    system_version = map['system_version'];
    log_in_date = map['log_in_date'];
    last_active_date = map['last_active_date'];
    ip = map['ip'];
    country = map['country'];
    region = map['region'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'is_current': is_current?.toMap(skipNulls: skipNulls),
      'is_password_pending': is_password_pending?.toMap(skipNulls: skipNulls),
      'can_accept_secret_chats': can_accept_secret_chats?.toMap(skipNulls: skipNulls),
      'can_accept_calls': can_accept_calls?.toMap(skipNulls: skipNulls),
      'api_id': api_id?.toMap(skipNulls: skipNulls),
      'application_name': application_name?.toMap(skipNulls: skipNulls),
      'application_version': application_version?.toMap(skipNulls: skipNulls),
      'is_official_application': is_official_application?.toMap(skipNulls: skipNulls),
      'device_model': device_model?.toMap(skipNulls: skipNulls),
      'platform': platform?.toMap(skipNulls: skipNulls),
      'system_version': system_version?.toMap(skipNulls: skipNulls),
      'log_in_date': log_in_date?.toMap(skipNulls: skipNulls),
      'last_active_date': last_active_date?.toMap(skipNulls: skipNulls),
      'ip': ip?.toMap(skipNulls: skipNulls),
      'country': country?.toMap(skipNulls: skipNulls),
      'region': region?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

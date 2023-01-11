import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/session_type.dart';

/// Contains information about one session in a Telegram application used by the current user. Sessions must be shown to the user in the returned order
class Session extends TdObject {
  String get tdType => 'session';

  /// Session identifier
  int64? id;

  /// True, if this session is the current session
  Bool? is_current;

  /// True, if a 2-step verification password is needed to complete authorization of the session
  Bool? is_password_pending;

  /// True, if incoming secret chats can be accepted by the session
  Bool? can_accept_secret_chats;

  /// True, if incoming calls can be accepted by the session
  Bool? can_accept_calls;

  /// Session type based on the system and application version, which can be used to display a corresponding icon
  SessionType? type;

  /// Telegram API identifier, as provided by the application
  int32? api_id;

  /// Name of the application, as provided by the application
  string? application_name;

  /// The version of the application, as provided by the application
  string? application_version;

  /// True, if the application is an official application or uses the api_id of an official application
  Bool? is_official_application;

  /// Model of the device the application has been run or is running on, as provided by the application
  string? device_model;

  /// Operating system the application has been run or is running on, as provided by the application
  string? platform;

  /// Version of the operating system the application has been run or is running on, as provided by the application
  string? system_version;

  /// Point in time (Unix timestamp) when the user has logged in
  int32? log_in_date;

  /// Point in time (Unix timestamp) when the session was last used
  int32? last_active_date;

  /// IP address from which the session was created, in human-readable format
  string? ip;

  /// A two-letter country code for the country from which the session was created, based on the IP address
  string? country;

  /// Region code from which the session was created, based on the IP address
  string? region;

  Session({
    super.extra,
    super.client_id,
    this.id,
    this.is_current,
    this.is_password_pending,
    this.can_accept_secret_chats,
    this.can_accept_calls,
    this.type,
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
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as SessionType;
    }
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
      'can_accept_secret_chats':
          can_accept_secret_chats?.toMap(skipNulls: skipNulls),
      'can_accept_calls': can_accept_calls?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'api_id': api_id?.toMap(skipNulls: skipNulls),
      'application_name': application_name?.toMap(skipNulls: skipNulls),
      'application_version': application_version?.toMap(skipNulls: skipNulls),
      'is_official_application':
          is_official_application?.toMap(skipNulls: skipNulls),
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

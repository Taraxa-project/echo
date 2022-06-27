import 'package:td_json_client/api/base.dart';

class ConnectedWebsite extends TdObject {
  String get tdType => 'connectedWebsite';

  String? extra;
  int? client_id;
  int64? id;
  string? domain_name;
  int53? bot_user_id;
  string? browser;
  string? platform;
  int32? log_in_date;
  int32? last_active_date;
  string? ip;
  string? location;

  ConnectedWebsite({
    this.extra,
    this.client_id,
    this.id,
    this.domain_name,
    this.bot_user_id,
    this.browser,
    this.platform,
    this.log_in_date,
    this.last_active_date,
    this.ip,
    this.location,
  });

  ConnectedWebsite.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    domain_name = map['domain_name'];
    bot_user_id = map['bot_user_id'];
    browser = map['browser'];
    platform = map['platform'];
    log_in_date = map['log_in_date'];
    last_active_date = map['last_active_date'];
    ip = map['ip'];
    location = map['location'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'domain_name': domain_name?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'browser': browser?.toMap(skipNulls: skipNulls),
      'platform': platform?.toMap(skipNulls: skipNulls),
      'log_in_date': log_in_date?.toMap(skipNulls: skipNulls),
      'last_active_date': last_active_date?.toMap(skipNulls: skipNulls),
      'ip': ip?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

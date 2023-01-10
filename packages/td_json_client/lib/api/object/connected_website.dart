import 'package:td_json_client/api/base.dart';


/// Contains information about one website the current user is logged in with Telegram
class ConnectedWebsite extends TdObject {
  String get tdType => 'connectedWebsite';


  /// Website identifier
  int64? id;

  /// The domain name of the website
  string? domain_name;

  /// User identifier of a bot linked with the website
  int53? bot_user_id;

  /// The version of a browser used to log in
  string? browser;

  /// Operating system the browser is running on
  string? platform;

  /// Point in time (Unix timestamp) when the user was logged in
  int32? log_in_date;

  /// Point in time (Unix timestamp) when obtained authorization was last used
  int32? last_active_date;

  /// IP address from which the user was logged in, in human-readable format
  string? ip;

  /// Human-readable description of a country and a region from which the user was logged in, based on the IP address
  string? location;

  ConnectedWebsite({
    super.extra,
    super.client_id,
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

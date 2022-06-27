import 'package:td_json_client/api/base.dart';

abstract class LoginUrlInfo extends TdObject {}

class LoginUrlInfoOpen extends LoginUrlInfo {
  String get tdType => 'loginUrlInfoOpen';

  string? extra;
  int? client_id;
  string? url;
  Bool? skip_confirm;

  LoginUrlInfoOpen({
    this.extra,
    this.client_id,
    this.url,
    this.skip_confirm,
  });

  LoginUrlInfoOpen.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    skip_confirm = map['skip_confirm'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'skip_confirm': skip_confirm?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class LoginUrlInfoRequestConfirmation extends LoginUrlInfo {
  String get tdType => 'loginUrlInfoRequestConfirmation';

  string? extra;
  int? client_id;
  string? url;
  string? domain;
  int53? bot_user_id;
  Bool? request_write_access;

  LoginUrlInfoRequestConfirmation({
    this.extra,
    this.client_id,
    this.url,
    this.domain,
    this.bot_user_id,
    this.request_write_access,
  });

  LoginUrlInfoRequestConfirmation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    domain = map['domain'];
    bot_user_id = map['bot_user_id'];
    request_write_access = map['request_write_access'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'domain': domain?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'request_write_access': request_write_access?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

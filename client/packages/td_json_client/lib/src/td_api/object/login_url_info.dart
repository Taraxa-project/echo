import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about an inline button of type inlineKeyboardButtonTypeLoginUrl
abstract class LoginUrlInfo extends TdObject {
  LoginUrlInfo({super.extra, super.client_id});
}

/// An HTTP url needs to be open
class LoginUrlInfoOpen extends LoginUrlInfo {
  String get tdType => 'loginUrlInfoOpen';

  /// The URL to open
  string? url;

  /// True, if there is no need to show an ordinary open URL confirm
  Bool? skip_confirm;

  LoginUrlInfoOpen({
    super.extra,
    super.client_id,
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

/// An authorization confirmation dialog needs to be shown to the user
class LoginUrlInfoRequestConfirmation extends LoginUrlInfo {
  String get tdType => 'loginUrlInfoRequestConfirmation';

  /// An HTTP URL to be opened
  string? url;

  /// A domain of the URL
  string? domain;

  /// User identifier of a bot linked with the website
  int53? bot_user_id;

  /// True, if the user needs to be requested to give the permission to the bot to send them messages
  Bool? request_write_access;

  LoginUrlInfoRequestConfirmation({
    super.extra,
    super.client_id,
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

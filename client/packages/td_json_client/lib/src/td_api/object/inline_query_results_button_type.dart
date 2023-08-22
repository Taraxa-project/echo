import 'package:td_json_client/src/td_api/td.dart';

/// Represents a type of a button in results of inline query
abstract class InlineQueryResultsButtonType extends TdObject {
  InlineQueryResultsButtonType({super.extra, super.client_id});
}

/// Describes the button that opens a private chat with the bot and sends a start message to the bot with the given parameter
class InlineQueryResultsButtonTypeStartBot extends InlineQueryResultsButtonType {
  String get tdType => 'inlineQueryResultsButtonTypeStartBot';

  /// The parameter for the bot start message
  string? parameter;

  InlineQueryResultsButtonTypeStartBot({
    super.extra,
    super.client_id,
    this.parameter,
  });

  InlineQueryResultsButtonTypeStartBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    parameter = map['parameter'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'parameter': parameter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Describes the button that opens a Web App by calling getWebAppUrl
class InlineQueryResultsButtonTypeWebApp extends InlineQueryResultsButtonType {
  String get tdType => 'inlineQueryResultsButtonTypeWebApp';

  /// An HTTP URL to pass to getWebAppUrl
  string? url;

  InlineQueryResultsButtonTypeWebApp({
    super.extra,
    super.client_id,
    this.url,
  });

  InlineQueryResultsButtonTypeWebApp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

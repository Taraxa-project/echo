import 'package:td_json_client/api/base.dart';

/// Returns a Telegram Passport authorization form for sharing data with a service
class GetPassportAuthorizationForm extends TdFunction {
  String get tdType => 'getPassportAuthorizationForm';
  String get tdReturnType => 'PassportAuthorizationForm';

  /// User identifier of the service's bot
  int53? bot_user_id;

  /// Telegram Passport element types requested by the service
  string? scope;

  /// Service's public key
  string? public_key;

  /// Unique request identifier provided by the service
  string? nonce;

  GetPassportAuthorizationForm({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.scope,
    this.public_key,
    this.nonce,
  });

  GetPassportAuthorizationForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    scope = map['scope'];
    public_key = map['public_key'];
    nonce = map['nonce'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
      'public_key': public_key?.toMap(skipNulls: skipNulls),
      'nonce': nonce?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

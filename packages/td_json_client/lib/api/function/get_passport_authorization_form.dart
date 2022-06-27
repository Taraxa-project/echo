import 'package:td_json_client/api/base.dart';

class GetPassportAuthorizationForm extends TdFunction {
  String get tdType => 'getPassportAuthorizationForm';
  String get tdReturnType => 'PassportAuthorizationForm';

  string? extra;
  int? client_id;
  int53? bot_user_id;
  string? scope;
  string? public_key;
  string? nonce;

  GetPassportAuthorizationForm({
    this.extra,
    this.client_id,
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

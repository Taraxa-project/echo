import 'package:td_json_client/api/base.dart';


/// Describes an action associated with a bank card number 
class BankCardActionOpenUrl extends TdObject {
  String get tdType => 'bankCardActionOpenUrl';


  /// Action text 
  string? text;

  /// The URL to be opened
  string? url;

  BankCardActionOpenUrl({
    super.extra,
    super.client_id,
    this.text,
    this.url,
  });

  BankCardActionOpenUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

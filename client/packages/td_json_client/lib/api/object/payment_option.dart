import 'package:td_json_client/api/base.dart';


/// Describes an additional payment option 
class PaymentOption extends TdObject {
  String get tdType => 'paymentOption';


  /// Title for the payment option 
  string? title;

  /// Payment form URL to be opened in a web view
  string? url;

  PaymentOption({
    super.extra,
    super.client_id,
    this.title,
    this.url,
  });

  PaymentOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

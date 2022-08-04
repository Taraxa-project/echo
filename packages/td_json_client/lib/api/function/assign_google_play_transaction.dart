import 'package:td_json_client/api/base.dart';


/// Informs server about a Telegram Premium purchase through Google Play. For official applications only 
class AssignGooglePlayTransaction extends TdFunction {
  String get tdType => 'assignGooglePlayTransaction';
  String get tdReturnType => 'Ok';


  /// Google Play purchase token
  string? purchase_token;

  AssignGooglePlayTransaction({
    super.extra,
    super.client_id,
    this.purchase_token,
  });

  AssignGooglePlayTransaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    purchase_token = map['purchase_token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'purchase_token': purchase_token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

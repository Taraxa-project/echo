import 'package:td_json_client/api/base.dart';


/// Informs server about a Telegram Premium purchase through App Store. For official applications only 
class AssignAppStoreTransaction extends TdFunction {
  String get tdType => 'assignAppStoreTransaction';
  String get tdReturnType => 'Ok';


  /// App Store receipt 
  bytes? receipt;

  /// Pass true if this is a restore of a Telegram Premium purchase
  Bool? is_restore;

  AssignAppStoreTransaction({
    super.extra,
    super.client_id,
    this.receipt,
    this.is_restore,
  });

  AssignAppStoreTransaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    receipt = map['receipt'];
    is_restore = map['is_restore'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'receipt': receipt?.toMap(skipNulls: skipNulls),
      'is_restore': is_restore?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

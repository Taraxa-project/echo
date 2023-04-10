import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about a bank card
class GetBankCardInfo extends TdFunction {
  String get tdType => 'getBankCardInfo';
  String get tdReturnType => 'BankCardInfo';

  /// The bank card number
  string? bank_card_number;

  GetBankCardInfo({
    super.extra,
    super.client_id,
    this.bank_card_number,
  });

  GetBankCardInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bank_card_number = map['bank_card_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bank_card_number': bank_card_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/bank_card_action_open_url.dart';


/// Information about a bank card 
class BankCardInfo extends TdObject {
  String get tdType => 'bankCardInfo';

  String? extra;
  int? client_id;

  /// Title of the bank card description 
  string? title;

  /// Actions that can be done with the bank card number
  vector<BankCardActionOpenUrl>? actions;

  BankCardInfo({
    this.extra,
    this.client_id,
    this.title,
    this.actions,
  });

  BankCardInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    if (map['actions'] != null) {
      actions = [];
      for (var someValue in map['actions']) {
        if (someValue != null) {
          actions?.add(TdApiMap.fromMap(someValue) as BankCardActionOpenUrl);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'actions': actions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

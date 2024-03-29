import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/bank_card_action_open_url.dart';

/// Information about a bank card
class BankCardInfo extends TdObject {
  String get tdType => 'bankCardInfo';

  /// Title of the bank card description
  string? title;

  /// Actions that can be done with the bank card number
  vector<BankCardActionOpenUrl>? actions;

  BankCardInfo({
    super.extra,
    super.client_id,
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';

class GetPaymentForm extends TdFunction {
  String get tdType => 'getPaymentForm';
  String get tdReturnType => 'PaymentForm';

  String? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  ThemeParameters? theme;

  GetPaymentForm({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.theme,
  });

  GetPaymentForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'theme': theme?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

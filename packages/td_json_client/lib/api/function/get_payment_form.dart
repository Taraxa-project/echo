import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';


/// Returns an invoice payment form. This method must be called when the user presses inlineKeyboardButtonBuy
class GetPaymentForm extends TdFunction {
  String get tdType => 'getPaymentForm';
  String get tdReturnType => 'PaymentForm';

  String? extra;
  int? client_id;

  /// Chat identifier of the Invoice message
  int53? chat_id;

  /// Message identifier
  int53? message_id;

  /// Preferred payment form theme; pass null to use the default theme
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
    if (map['theme'] != null) {
      theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
    }
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

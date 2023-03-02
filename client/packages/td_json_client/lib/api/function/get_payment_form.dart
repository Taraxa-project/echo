import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_invoice.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';


/// Returns an invoice payment form. This method must be called when the user presses inlineKeyboardButtonBuy
class GetPaymentForm extends TdFunction {
  String get tdType => 'getPaymentForm';
  String get tdReturnType => 'PaymentForm';


  /// The invoice
  InputInvoice? input_invoice;

  /// Preferred payment form theme; pass null to use the default theme
  ThemeParameters? theme;

  GetPaymentForm({
    super.extra,
    super.client_id,
    this.input_invoice,
    this.theme,
  });

  GetPaymentForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['input_invoice'] != null) {
      input_invoice = TdApiMap.fromMap(map['input_invoice']) as InputInvoice;
    }
    if (map['theme'] != null) {
      theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'input_invoice': input_invoice?.toMap(skipNulls: skipNulls),
      'theme': theme?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

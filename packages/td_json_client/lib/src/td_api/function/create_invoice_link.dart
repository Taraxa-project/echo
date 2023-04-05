import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_message_content.dart';

/// Creates a link for the given invoice; for bots only
class CreateInvoiceLink extends TdFunction {
  String get tdType => 'createInvoiceLink';
  String get tdReturnType => 'HttpUrl';

  /// Information about the invoice of the type inputMessageInvoice
  InputMessageContent? invoice;

  CreateInvoiceLink({
    super.extra,
    super.client_id,
    this.invoice,
  });

  CreateInvoiceLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['invoice'] != null) {
      invoice = TdApiMap.fromMap(map['invoice']) as InputMessageContent;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invoice': invoice?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

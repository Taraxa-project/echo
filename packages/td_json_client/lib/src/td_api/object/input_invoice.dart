import 'package:td_json_client/src/td_api/td.dart';

/// Describes an invoice to process
abstract class InputInvoice extends TdObject {
  InputInvoice({super.extra, super.client_id});
}

/// An invoice from a message of the type messageInvoice
class InputInvoiceMessage extends InputInvoice {
  String get tdType => 'inputInvoiceMessage';

  /// Chat identifier of the message
  int53? chat_id;

  /// Message identifier
  int53? message_id;

  InputInvoiceMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  InputInvoiceMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An invoice from a link of the type internalLinkTypeInvoice
class InputInvoiceName extends InputInvoice {
  String get tdType => 'inputInvoiceName';

  /// Name of the invoice
  string? name;

  InputInvoiceName({
    super.extra,
    super.client_id,
    this.name,
  });

  InputInvoiceName.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

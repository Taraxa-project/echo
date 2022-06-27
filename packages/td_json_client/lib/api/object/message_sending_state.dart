import 'package:td_json_client/api/base.dart';

abstract class MessageSendingState extends TdObject {}

class MessageSendingStatePending extends MessageSendingState {
  String get tdType => 'messageSendingStatePending';

  String? extra;
  int? client_id;

  MessageSendingStatePending({
    this.extra,
    this.client_id,
  });

  MessageSendingStatePending.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageSendingStateFailed extends MessageSendingState {
  String get tdType => 'messageSendingStateFailed';

  String? extra;
  int? client_id;
  int32? error_code;
  string? error_message;
  Bool? can_retry;
  Bool? need_another_sender;
  double? retry_after;

  MessageSendingStateFailed({
    this.extra,
    this.client_id,
    this.error_code,
    this.error_message,
    this.can_retry,
    this.need_another_sender,
    this.retry_after,
  });

  MessageSendingStateFailed.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    error_code = map['error_code'];
    error_message = map['error_message'];
    can_retry = map['can_retry'];
    need_another_sender = map['need_another_sender'];
    retry_after = map['retry_after'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'error_code': error_code?.toMap(skipNulls: skipNulls),
      'error_message': error_message?.toMap(skipNulls: skipNulls),
      'can_retry': can_retry?.toMap(skipNulls: skipNulls),
      'need_another_sender': need_another_sender?.toMap(skipNulls: skipNulls),
      'retry_after': retry_after?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

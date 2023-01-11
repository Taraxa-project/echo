import 'package:td_json_client/api/base.dart';

/// Contains information about the sending state of the message
abstract class MessageSendingState extends TdObject {
  MessageSendingState({super.extra, super.client_id});
}

/// The message is being sent now, but has not yet been delivered to the server
class MessageSendingStatePending extends MessageSendingState {
  String get tdType => 'messageSendingStatePending';

  MessageSendingStatePending({
    super.extra,
    super.client_id,
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

/// The message failed to be sent
class MessageSendingStateFailed extends MessageSendingState {
  String get tdType => 'messageSendingStateFailed';

  /// An error code; 0 if unknown
  int32? error_code;

  /// Error message
  string? error_message;

  /// True, if the message can be re-sent
  Bool? can_retry;

  /// True, if the message can be re-sent only on behalf of a different sender
  Bool? need_another_sender;

  /// Time left before the message can be re-sent, in seconds. No update is sent when this field changes
  double? retry_after;

  MessageSendingStateFailed({
    super.extra,
    super.client_id,
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

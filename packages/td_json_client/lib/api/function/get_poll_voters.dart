import 'package:td_json_client/api/base.dart';


/// Returns users voted for the specified option in a non-anonymous polls. For optimal performance, the number of returned users is chosen by TDLib
class GetPollVoters extends TdFunction {
  String get tdType => 'getPollVoters';
  String get tdReturnType => 'Users';

  String? extra;
  int? client_id;

  /// Identifier of the chat to which the poll belongs 
  int53? chat_id;

  /// Identifier of the message containing the poll
  int53? message_id;

  /// 0-based identifier of the answer option
  int32? option_id;

  /// Number of users to skip in the result; must be non-negative
  int32? offset;

  /// The maximum number of users to be returned; must be positive and can't be greater than 50. For optimal performance, the number of returned users is chosen by TDLib and can be smaller than the specified limit, even if the end of the voter list has not been reached
  int32? limit;

  GetPollVoters({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.option_id,
    this.offset,
    this.limit,
  });

  GetPollVoters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    option_id = map['option_id'];
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'option_id': option_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

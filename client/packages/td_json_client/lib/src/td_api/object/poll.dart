import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/poll_option.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';
import 'package:td_json_client/src/td_api/object/poll_type.dart';

/// Describes a poll
class Poll extends TdObject {
  String get tdType => 'poll';

  /// Unique poll identifier
  int64? id;

  /// Poll question; 1-300 characters
  string? question;

  /// List of poll answer options
  vector<PollOption>? options;

  /// Total number of voters, participating in the poll
  int32? total_voter_count;

  /// Identifiers of recent voters, if the poll is non-anonymous
  vector<MessageSender>? recent_voter_ids;

  /// True, if the poll is anonymous
  Bool? is_anonymous;

  /// Type of the poll
  PollType? type;

  /// Amount of time the poll will be active after creation, in seconds
  int32? open_period;

  /// Point in time (Unix timestamp) when the poll will automatically be closed
  int32? close_date;

  /// True, if the poll is closed
  Bool? is_closed;

  Poll({
    super.extra,
    super.client_id,
    this.id,
    this.question,
    this.options,
    this.total_voter_count,
    this.recent_voter_ids,
    this.is_anonymous,
    this.type,
    this.open_period,
    this.close_date,
    this.is_closed,
  });

  Poll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    question = map['question'];
    if (map['options'] != null) {
      options = [];
      for (var someValue in map['options']) {
        if (someValue != null) {
          options?.add(TdApiMap.fromMap(someValue) as PollOption);
        }
      }
    }
    total_voter_count = map['total_voter_count'];
    if (map['recent_voter_ids'] != null) {
      recent_voter_ids = [];
      for (var someValue in map['recent_voter_ids']) {
        if (someValue != null) {
          recent_voter_ids?.add(TdApiMap.fromMap(someValue) as MessageSender);
        }
      }
    }
    is_anonymous = map['is_anonymous'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as PollType;
    }
    open_period = map['open_period'];
    close_date = map['close_date'];
    is_closed = map['is_closed'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'question': question?.toMap(skipNulls: skipNulls),
      'options': options?.toMap(skipNulls: skipNulls),
      'total_voter_count': total_voter_count?.toMap(skipNulls: skipNulls),
      'recent_voter_ids': recent_voter_ids?.toMap(skipNulls: skipNulls),
      'is_anonymous': is_anonymous?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'open_period': open_period?.toMap(skipNulls: skipNulls),
      'close_date': close_date?.toMap(skipNulls: skipNulls),
      'is_closed': is_closed?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

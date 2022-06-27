import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/poll_option.dart';
import 'package:td_json_client/api/object/poll_type.dart';

class Poll extends TdObject {
  String get tdType => 'poll';

  string? extra;
  int? client_id;
  int64? id;
  string? question;
  vector<PollOption>? options;
  int32? total_voter_count;
  vector<int53>? recent_voter_user_ids;
  Bool? is_anonymous;
  PollType? type;
  int32? open_period;
  int32? close_date;
  Bool? is_closed;

  Poll({
    this.extra,
    this.client_id,
    this.id,
    this.question,
    this.options,
    this.total_voter_count,
    this.recent_voter_user_ids,
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
    if (map['options']) {
      options = [];
      for (var someValue in map['options']) {
        options?.add(TdApiMap.fromMap(someValue) as PollOption);
      }
    }
    total_voter_count = map['total_voter_count'];
    if (map['recent_voter_user_ids']) {
      recent_voter_user_ids = [];
      for (var someValue in map['recent_voter_user_ids']) {
        recent_voter_user_ids?.add(someValue);
      }
    }
    is_anonymous = map['is_anonymous'];
    type = TdApiMap.fromMap(map['type']) as PollType;
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
      'recent_voter_user_ids': recent_voter_user_ids?.toMap(skipNulls: skipNulls),
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

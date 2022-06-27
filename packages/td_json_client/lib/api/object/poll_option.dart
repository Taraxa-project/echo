import 'package:td_json_client/api/base.dart';

class PollOption extends TdObject {
  String get tdType => 'pollOption';

  string? extra;
  int? client_id;
  string? text;
  int32? voter_count;
  int32? vote_percentage;
  Bool? is_chosen;
  Bool? is_being_chosen;

  PollOption({
    this.extra,
    this.client_id,
    this.text,
    this.voter_count,
    this.vote_percentage,
    this.is_chosen,
    this.is_being_chosen,
  });

  PollOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    voter_count = map['voter_count'];
    vote_percentage = map['vote_percentage'];
    is_chosen = map['is_chosen'];
    is_being_chosen = map['is_being_chosen'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'voter_count': voter_count?.toMap(skipNulls: skipNulls),
      'vote_percentage': vote_percentage?.toMap(skipNulls: skipNulls),
      'is_chosen': is_chosen?.toMap(skipNulls: skipNulls),
      'is_being_chosen': is_being_chosen?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

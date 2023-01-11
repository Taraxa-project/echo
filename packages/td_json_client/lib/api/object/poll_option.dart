import 'package:td_json_client/api/base.dart';


/// Describes one answer option of a poll
class PollOption extends TdObject {
  String get tdType => 'pollOption';


  /// Option text; 1-100 characters
  string? text;

  /// Number of voters for this option, available only for closed or voted polls
  int32? voter_count;

  /// The percentage of votes for this option; 0-100
  int32? vote_percentage;

  /// True, if the option was chosen by the user
  Bool? is_chosen;

  /// True, if the option is being chosen by a pending setPollAnswer request
  Bool? is_being_chosen;

  PollOption({
    super.extra,
    super.client_id,
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

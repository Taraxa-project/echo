import 'package:td_json_client/api/base.dart';

class SearchCallMessages extends TdFunction {
  String get tdType => 'searchCallMessages';
  String get tdReturnType => 'Messages';

  String? extra;
  int? client_id;
  int53? from_message_id;
  int32? limit;
  Bool? only_missed;

  SearchCallMessages({
    this.extra,
    this.client_id,
    this.from_message_id,
    this.limit,
    this.only_missed,
  });

  SearchCallMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    from_message_id = map['from_message_id'];
    limit = map['limit'];
    only_missed = map['only_missed'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'only_missed': only_missed?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

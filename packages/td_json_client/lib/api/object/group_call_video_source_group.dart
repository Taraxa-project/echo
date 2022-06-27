import 'package:td_json_client/api/base.dart';

class GroupCallVideoSourceGroup extends TdObject {
  String get tdType => 'groupCallVideoSourceGroup';

  string? extra;
  int? client_id;
  string? semantics;
  vector<int32>? source_ids;

  GroupCallVideoSourceGroup({
    this.extra,
    this.client_id,
    this.semantics,
    this.source_ids,
  });

  GroupCallVideoSourceGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    semantics = map['semantics'];
    if (map['source_ids']) {
      source_ids = [];
      for (var someValue in map['source_ids']) {
        source_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'semantics': semantics?.toMap(skipNulls: skipNulls),
      'source_ids': source_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

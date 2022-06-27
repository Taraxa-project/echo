import 'package:td_json_client/api/base.dart';

class CreateBasicGroupChat extends TdFunction {
  String get tdType => 'createBasicGroupChat';
  String get tdReturnType => 'Chat';

  string? extra;
  int? client_id;
  int53? basic_group_id;
  Bool? force;

  CreateBasicGroupChat({
    this.extra,
    this.client_id,
    this.basic_group_id,
    this.force,
  });

  CreateBasicGroupChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    basic_group_id = map['basic_group_id'];
    force = map['force'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'basic_group_id': basic_group_id?.toMap(skipNulls: skipNulls),
      'force': force?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

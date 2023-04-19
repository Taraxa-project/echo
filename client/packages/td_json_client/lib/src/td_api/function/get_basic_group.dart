import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about a basic group by its identifier. This is an offline request if the current user is not a bot
class GetBasicGroup extends TdFunction {
  String get tdType => 'getBasicGroup';
  String get tdReturnType => 'BasicGroup';

  /// Basic group identifier
  int53? basic_group_id;

  GetBasicGroup({
    super.extra,
    super.client_id,
    this.basic_group_id,
  });

  GetBasicGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    basic_group_id = map['basic_group_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'basic_group_id': basic_group_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
import 'package:td_json_client/api/base.dart';


/// Returns full information about a basic group by its identifier 
class GetBasicGroupFullInfo extends TdFunction {
  String get tdType => 'getBasicGroupFullInfo';
  String get tdReturnType => 'BasicGroupFullInfo';

  String? extra;
  int? client_id;

  /// Basic group identifier
  int53? basic_group_id;

  GetBasicGroupFullInfo({
    this.extra,
    this.client_id,
    this.basic_group_id,
  });

  GetBasicGroupFullInfo.fromMap(Map<String, dynamic> map) {
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

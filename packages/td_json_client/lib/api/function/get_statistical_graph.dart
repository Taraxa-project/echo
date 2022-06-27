import 'package:td_json_client/api/base.dart';

class GetStatisticalGraph extends TdFunction {
  String get tdType => 'getStatisticalGraph';
  String get tdReturnType => 'StatisticalGraph';

  String? extra;
  int? client_id;
  int53? chat_id;
  string? token;
  int53? x;

  GetStatisticalGraph({
    this.extra,
    this.client_id,
    this.chat_id,
    this.token,
    this.x,
  });

  GetStatisticalGraph.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    token = map['token'];
    x = map['x'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
      'x': x?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

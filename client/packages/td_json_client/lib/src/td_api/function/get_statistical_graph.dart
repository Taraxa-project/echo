import 'package:td_json_client/src/td_api/td.dart';

/// Loads an asynchronous or a zoomed in statistical graph
class GetStatisticalGraph extends TdFunction {
  String get tdType => 'getStatisticalGraph';
  String get tdReturnType => 'StatisticalGraph';

  /// Chat identifier
  int53? chat_id;

  /// The token for graph loading
  string? token;

  /// X-value for zoomed in graph or 0 otherwise
  int53? x;

  GetStatisticalGraph({
    super.extra,
    super.client_id,
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

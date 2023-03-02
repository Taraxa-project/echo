import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/statistical_graph.dart';


/// A detailed statistics about a message 
class MessageStatistics extends TdObject {
  String get tdType => 'messageStatistics';


  /// A graph containing number of message views and shares
  StatisticalGraph? message_interaction_graph;

  MessageStatistics({
    super.extra,
    super.client_id,
    this.message_interaction_graph,
  });

  MessageStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['message_interaction_graph'] != null) {
      message_interaction_graph = TdApiMap.fromMap(map['message_interaction_graph']) as StatisticalGraph;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_interaction_graph': message_interaction_graph?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

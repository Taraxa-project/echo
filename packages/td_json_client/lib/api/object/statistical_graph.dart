import 'package:td_json_client/api/base.dart';

/// Describes a statistical graph
abstract class StatisticalGraph extends TdObject {
  StatisticalGraph({super.extra, super.client_id});
}


/// A graph data 
class StatisticalGraphData extends StatisticalGraph {
  String get tdType => 'statisticalGraphData';


  /// Graph data in JSON format 
  string? json_data;

  /// If non-empty, a token which can be used to receive a zoomed in graph
  string? zoom_token;

  StatisticalGraphData({
    super.extra,
    super.client_id,
    this.json_data,
    this.zoom_token,
  });

  StatisticalGraphData.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    json_data = map['json_data'];
    zoom_token = map['zoom_token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'json_data': json_data?.toMap(skipNulls: skipNulls),
      'zoom_token': zoom_token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The graph data to be asynchronously loaded through getStatisticalGraph 
class StatisticalGraphAsync extends StatisticalGraph {
  String get tdType => 'statisticalGraphAsync';


  /// The token to use for data loading
  string? token;

  StatisticalGraphAsync({
    super.extra,
    super.client_id,
    this.token,
  });

  StatisticalGraphAsync.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An error message to be shown to the user instead of the graph 
class StatisticalGraphError extends StatisticalGraph {
  String get tdType => 'statisticalGraphError';


  /// The error message
  string? error_message;

  StatisticalGraphError({
    super.extra,
    super.client_id,
    this.error_message,
  });

  StatisticalGraphError.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    error_message = map['error_message'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'error_message': error_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

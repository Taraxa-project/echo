import 'package:td_json_client/api/base.dart';

abstract class StatisticalGraph extends TdObject {}

class StatisticalGraphData extends StatisticalGraph {
  String get tdType => 'statisticalGraphData';

  String? extra;
  int? client_id;
  string? json_data;
  string? zoom_token;

  StatisticalGraphData({
    this.extra,
    this.client_id,
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
class StatisticalGraphAsync extends StatisticalGraph {
  String get tdType => 'statisticalGraphAsync';

  String? extra;
  int? client_id;
  string? token;

  StatisticalGraphAsync({
    this.extra,
    this.client_id,
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
class StatisticalGraphError extends StatisticalGraph {
  String get tdType => 'statisticalGraphError';

  String? extra;
  int? client_id;
  string? error_message;

  StatisticalGraphError({
    this.extra,
    this.client_id,
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

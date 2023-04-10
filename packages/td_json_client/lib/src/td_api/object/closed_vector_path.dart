import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/vector_path_command.dart';

/// Represents a closed vector path. The path begins at the end point of the last command
class ClosedVectorPath extends TdObject {
  String get tdType => 'closedVectorPath';

  /// List of vector path commands
  vector<VectorPathCommand>? commands;

  ClosedVectorPath({
    super.extra,
    super.client_id,
    this.commands,
  });

  ClosedVectorPath.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['commands'] != null) {
      commands = [];
      for (var someValue in map['commands']) {
        if (someValue != null) {
          commands?.add(TdApiMap.fromMap(someValue) as VectorPathCommand);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'commands': commands?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

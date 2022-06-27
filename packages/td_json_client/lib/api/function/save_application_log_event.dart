import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/json_value.dart';

class SaveApplicationLogEvent extends TdFunction {
  String get tdType => 'saveApplicationLogEvent';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  string? type;
  int53? chat_id;
  JsonValue? data;

  SaveApplicationLogEvent({
    this.extra,
    this.client_id,
    this.type,
    this.chat_id,
    this.data,
  });

  SaveApplicationLogEvent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = map['type'];
    chat_id = map['chat_id'];
    data = TdApiMap.fromMap(map['data']) as JsonValue;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

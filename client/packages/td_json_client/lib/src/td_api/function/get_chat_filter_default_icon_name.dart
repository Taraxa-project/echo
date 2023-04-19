import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_filter.dart';

/// Returns default icon name for a filter. Can be called synchronously
class GetChatFilterDefaultIconName extends TdFunction {
  String get tdType => 'getChatFilterDefaultIconName';
  String get tdReturnType => 'Text';

  /// Chat filter
  ChatFilter? filter;

  GetChatFilterDefaultIconName({
    super.extra,
    super.client_id,
    this.filter,
  });

  GetChatFilterDefaultIconName.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as ChatFilter;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

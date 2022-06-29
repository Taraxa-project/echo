import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_location.dart';


/// Changes the location of a chat. Available only for some location-based supergroups, use supergroupFullInfo.can_set_location to check whether the method is allowed to use 
class SetChatLocation extends TdFunction {
  String get tdType => 'setChatLocation';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New location for the chat; must be valid and not null
  ChatLocation? location;

  SetChatLocation({
    this.extra,
    this.client_id,
    this.chat_id,
    this.location,
  });

  SetChatLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as ChatLocation;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

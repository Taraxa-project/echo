import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sponsor_type.dart';
import 'package:td_json_client/src/td_api/object/chat_photo_info.dart';

/// Information about the sponsor of a message
class MessageSponsor extends TdObject {
  String get tdType => 'messageSponsor';

  /// Type of the sponsor
  MessageSponsorType? type;

  /// Photo of the sponsor; may be null if must not be shown
  ChatPhotoInfo? photo;

  /// Additional optional information about the sponsor to be shown along with the message
  string? info;

  MessageSponsor({
    super.extra,
    super.client_id,
    this.type,
    this.photo,
    this.info,
  });

  MessageSponsor.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as MessageSponsorType;
    }
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhotoInfo;
    }
    info = map['info'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'info': info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

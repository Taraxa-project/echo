import 'package:td_json_client/api/base.dart';


/// Describes a color to highlight a bot added to attachment menu 
class AttachmentMenuBotColor extends TdObject {
  String get tdType => 'attachmentMenuBotColor';

  String? extra;
  int? client_id;

  /// Color in the RGB24 format for light themes 
  int32? light_color;

  /// Color in the RGB24 format for dark themes
  int32? dark_color;

  AttachmentMenuBotColor({
    this.extra,
    this.client_id,
    this.light_color,
    this.dark_color,
  });

  AttachmentMenuBotColor.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    light_color = map['light_color'];
    dark_color = map['dark_color'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'light_color': light_color?.toMap(skipNulls: skipNulls),
      'dark_color': dark_color?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

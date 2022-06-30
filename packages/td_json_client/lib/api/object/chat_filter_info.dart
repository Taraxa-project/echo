import 'package:td_json_client/api/base.dart';


/// Contains basic information about a chat filter
class ChatFilterInfo extends TdObject {
  String get tdType => 'chatFilterInfo';


  /// Unique chat filter identifier
  int32? id;

  /// The title of the filter; 1-12 characters without line feeds
  string? title;

  /// The chosen or default icon name for short filter representation. One of "All", "Unread", "Unmuted", "Bots", "Channels", "Groups", "Private", "Custom", "Setup", "Cat", "Crown", "Favorite", "Flower", "Game", "Home", "Love", "Mask", "Party", "Sport", "Study", "Trade", "Travel", "Work"
  string? icon_name;

  ChatFilterInfo({
    super.extra,
    super.client_id,
    this.id,
    this.title,
    this.icon_name,
  });

  ChatFilterInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    icon_name = map['icon_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'icon_name': icon_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

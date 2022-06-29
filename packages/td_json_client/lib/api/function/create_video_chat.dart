import 'package:td_json_client/api/base.dart';


/// Creates a video chat (a group call bound to a chat). Available only for basic groups, supergroups and channels; requires can_manage_video_chats rights
class CreateVideoChat extends TdFunction {
  String get tdType => 'createVideoChat';
  String get tdReturnType => 'GroupCallId';

  String? extra;
  int? client_id;

  /// Chat identifier, in which the video chat will be created
  int53? chat_id;

  /// Group call title; if empty, chat title will be used
  string? title;

  /// Point in time (Unix timestamp) when the group call is supposed to be started by an administrator; 0 to start the video chat immediately. The date must be at least 10 seconds and at most 8 days in the future
  int32? start_date;

  CreateVideoChat({
    this.extra,
    this.client_id,
    this.chat_id,
    this.title,
    this.start_date,
  });

  CreateVideoChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    title = map['title'];
    start_date = map['start_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'start_date': start_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

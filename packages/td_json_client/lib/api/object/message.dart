import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/message_sending_state.dart';
import 'package:td_json_client/api/object/message_scheduling_state.dart';
import 'package:td_json_client/api/object/message_forward_info.dart';
import 'package:td_json_client/api/object/message_interaction_info.dart';
import 'package:td_json_client/api/object/unread_reaction.dart';
import 'package:td_json_client/api/object/message_content.dart';
import 'package:td_json_client/api/object/reply_markup.dart';

class Message extends TdObject {
  String get tdType => 'message';

  string? extra;
  int? client_id;
  int53? id;
  MessageSender? sender_id;
  int53? chat_id;
  MessageSendingState? sending_state;
  MessageSchedulingState? scheduling_state;
  Bool? is_outgoing;
  Bool? is_pinned;
  Bool? can_be_edited;
  Bool? can_be_forwarded;
  Bool? can_be_saved;
  Bool? can_be_deleted_only_for_self;
  Bool? can_be_deleted_for_all_users;
  Bool? can_get_added_reactions;
  Bool? can_get_statistics;
  Bool? can_get_message_thread;
  Bool? can_get_viewers;
  Bool? can_get_media_timestamp_links;
  Bool? has_timestamped_media;
  Bool? is_channel_post;
  Bool? contains_unread_mention;
  int32? date;
  int32? edit_date;
  MessageForwardInfo? forward_info;
  MessageInteractionInfo? interaction_info;
  vector<UnreadReaction>? unread_reactions;
  int53? reply_in_chat_id;
  int53? reply_to_message_id;
  int53? message_thread_id;
  int32? ttl;
  double? ttl_expires_in;
  int53? via_bot_user_id;
  string? author_signature;
  int64? media_album_id;
  string? restriction_reason;
  MessageContent? content;
  ReplyMarkup? reply_markup;

  Message({
    this.extra,
    this.client_id,
    this.id,
    this.sender_id,
    this.chat_id,
    this.sending_state,
    this.scheduling_state,
    this.is_outgoing,
    this.is_pinned,
    this.can_be_edited,
    this.can_be_forwarded,
    this.can_be_saved,
    this.can_be_deleted_only_for_self,
    this.can_be_deleted_for_all_users,
    this.can_get_added_reactions,
    this.can_get_statistics,
    this.can_get_message_thread,
    this.can_get_viewers,
    this.can_get_media_timestamp_links,
    this.has_timestamped_media,
    this.is_channel_post,
    this.contains_unread_mention,
    this.date,
    this.edit_date,
    this.forward_info,
    this.interaction_info,
    this.unread_reactions,
    this.reply_in_chat_id,
    this.reply_to_message_id,
    this.message_thread_id,
    this.ttl,
    this.ttl_expires_in,
    this.via_bot_user_id,
    this.author_signature,
    this.media_album_id,
    this.restriction_reason,
    this.content,
    this.reply_markup,
  });

  Message.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    chat_id = map['chat_id'];
    sending_state = TdApiMap.fromMap(map['sending_state']) as MessageSendingState;
    scheduling_state = TdApiMap.fromMap(map['scheduling_state']) as MessageSchedulingState;
    is_outgoing = map['is_outgoing'];
    is_pinned = map['is_pinned'];
    can_be_edited = map['can_be_edited'];
    can_be_forwarded = map['can_be_forwarded'];
    can_be_saved = map['can_be_saved'];
    can_be_deleted_only_for_self = map['can_be_deleted_only_for_self'];
    can_be_deleted_for_all_users = map['can_be_deleted_for_all_users'];
    can_get_added_reactions = map['can_get_added_reactions'];
    can_get_statistics = map['can_get_statistics'];
    can_get_message_thread = map['can_get_message_thread'];
    can_get_viewers = map['can_get_viewers'];
    can_get_media_timestamp_links = map['can_get_media_timestamp_links'];
    has_timestamped_media = map['has_timestamped_media'];
    is_channel_post = map['is_channel_post'];
    contains_unread_mention = map['contains_unread_mention'];
    date = map['date'];
    edit_date = map['edit_date'];
    forward_info = TdApiMap.fromMap(map['forward_info']) as MessageForwardInfo;
    interaction_info = TdApiMap.fromMap(map['interaction_info']) as MessageInteractionInfo;
    if (map['unread_reactions']) {
      unread_reactions = [];
      for (var someValue in map['unread_reactions']) {
        unread_reactions?.add(TdApiMap.fromMap(someValue) as UnreadReaction);
      }
    }
    reply_in_chat_id = map['reply_in_chat_id'];
    reply_to_message_id = map['reply_to_message_id'];
    message_thread_id = map['message_thread_id'];
    ttl = map['ttl'];
    ttl_expires_in = map['ttl_expires_in'];
    via_bot_user_id = map['via_bot_user_id'];
    author_signature = map['author_signature'];
    media_album_id = map['media_album_id'];
    restriction_reason = map['restriction_reason'];
    content = TdApiMap.fromMap(map['content']) as MessageContent;
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'sending_state': sending_state?.toMap(skipNulls: skipNulls),
      'scheduling_state': scheduling_state?.toMap(skipNulls: skipNulls),
      'is_outgoing': is_outgoing?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
      'can_be_edited': can_be_edited?.toMap(skipNulls: skipNulls),
      'can_be_forwarded': can_be_forwarded?.toMap(skipNulls: skipNulls),
      'can_be_saved': can_be_saved?.toMap(skipNulls: skipNulls),
      'can_be_deleted_only_for_self': can_be_deleted_only_for_self?.toMap(skipNulls: skipNulls),
      'can_be_deleted_for_all_users': can_be_deleted_for_all_users?.toMap(skipNulls: skipNulls),
      'can_get_added_reactions': can_get_added_reactions?.toMap(skipNulls: skipNulls),
      'can_get_statistics': can_get_statistics?.toMap(skipNulls: skipNulls),
      'can_get_message_thread': can_get_message_thread?.toMap(skipNulls: skipNulls),
      'can_get_viewers': can_get_viewers?.toMap(skipNulls: skipNulls),
      'can_get_media_timestamp_links': can_get_media_timestamp_links?.toMap(skipNulls: skipNulls),
      'has_timestamped_media': has_timestamped_media?.toMap(skipNulls: skipNulls),
      'is_channel_post': is_channel_post?.toMap(skipNulls: skipNulls),
      'contains_unread_mention': contains_unread_mention?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'edit_date': edit_date?.toMap(skipNulls: skipNulls),
      'forward_info': forward_info?.toMap(skipNulls: skipNulls),
      'interaction_info': interaction_info?.toMap(skipNulls: skipNulls),
      'unread_reactions': unread_reactions?.toMap(skipNulls: skipNulls),
      'reply_in_chat_id': reply_in_chat_id?.toMap(skipNulls: skipNulls),
      'reply_to_message_id': reply_to_message_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'ttl': ttl?.toMap(skipNulls: skipNulls),
      'ttl_expires_in': ttl_expires_in?.toMap(skipNulls: skipNulls),
      'via_bot_user_id': via_bot_user_id?.toMap(skipNulls: skipNulls),
      'author_signature': author_signature?.toMap(skipNulls: skipNulls),
      'media_album_id': media_album_id?.toMap(skipNulls: skipNulls),
      'restriction_reason': restriction_reason?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

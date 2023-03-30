import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';
import 'package:td_json_client/src/td_api/object/message_sending_state.dart';
import 'package:td_json_client/src/td_api/object/message_scheduling_state.dart';
import 'package:td_json_client/src/td_api/object/message_forward_info.dart';
import 'package:td_json_client/src/td_api/object/message_interaction_info.dart';
import 'package:td_json_client/src/td_api/object/unread_reaction.dart';
import 'package:td_json_client/src/td_api/object/message_content.dart';
import 'package:td_json_client/src/td_api/object/reply_markup.dart';

/// Describes a message
class Message extends TdObject {
  String get tdType => 'message';

  /// Message identifier; unique for the chat to which the message belongs
  int53? id;

  /// Identifier of the sender of the message
  MessageSender? sender_id;

  /// Chat identifier
  int53? chat_id;

  /// The sending state of the message; may be null
  MessageSendingState? sending_state;

  /// The scheduling state of the message; may be null
  MessageSchedulingState? scheduling_state;

  /// True, if the message is outgoing
  Bool? is_outgoing;

  /// True, if the message is pinned
  Bool? is_pinned;

  /// True, if the message can be edited. For live location and poll messages this fields shows whether editMessageLiveLocation or stopPoll can be used with this message by the application
  Bool? can_be_edited;

  /// True, if the message can be forwarded
  Bool? can_be_forwarded;

  /// True, if content of the message can be saved locally or copied
  Bool? can_be_saved;

  /// True, if the message can be deleted only for the current user while other users will continue to see it
  Bool? can_be_deleted_only_for_self;

  /// True, if the message can be deleted for all users
  Bool? can_be_deleted_for_all_users;

  /// True, if the list of added reactions is available through getMessageAddedReactions
  Bool? can_get_added_reactions;

  /// True, if the message statistics are available through getMessageStatistics
  Bool? can_get_statistics;

  /// True, if information about the message thread is available through getMessageThread and getMessageThreadHistory
  Bool? can_get_message_thread;

  /// True, if chat members already viewed the message can be received through getMessageViewers
  Bool? can_get_viewers;

  /// True, if media timestamp links can be generated for media timestamp entities in the message text, caption or web page description through getMessageLink
  Bool? can_get_media_timestamp_links;

  /// True, if reactions on the message can be reported through reportMessageReactions
  Bool? can_report_reactions;

  /// True, if media timestamp entities refers to a media in this message as opposed to a media in the replied message
  Bool? has_timestamped_media;

  /// True, if the message is a channel post. All messages to channels are channel posts, all other messages are not channel posts
  Bool? is_channel_post;

  /// True, if the message is a forum topic message
  Bool? is_topic_message;

  /// True, if the message contains an unread mention for the current user
  Bool? contains_unread_mention;

  /// Point in time (Unix timestamp) when the message was sent
  int32? date;

  /// Point in time (Unix timestamp) when the message was last edited
  int32? edit_date;

  /// Information about the initial message sender; may be null
  MessageForwardInfo? forward_info;

  /// Information about interactions with the message; may be null
  MessageInteractionInfo? interaction_info;

  /// Information about unread reactions added to the message
  vector<UnreadReaction>? unread_reactions;

  /// If non-zero, the identifier of the chat to which the replied message belongs; Currently, only messages in the Replies chat can have different reply_in_chat_id and chat_id
  int53? reply_in_chat_id;

  /// If non-zero, the identifier of the message this message is replying to; can be the identifier of a deleted message
  int53? reply_to_message_id;

  /// If non-zero, the identifier of the message thread the message belongs to; unique within the chat to which the message belongs
  int53? message_thread_id;

  /// The message's self-destruct time, in seconds; 0 if none. TDLib will send updateDeleteMessages or updateMessageContent once the time expires
  int32? self_destruct_time;

  /// Time left before the message self-destruct timer expires, in seconds. If the self-destruct timer isn't started yet, equals to the value of the self_destruct_time field
  double? self_destruct_in;

  /// Time left before the message will be automatically deleted by message_auto_delete_time setting of the chat, in seconds; 0 if never. TDLib will send updateDeleteMessages or updateMessageContent once the time expires
  double? auto_delete_in;

  /// If non-zero, the user identifier of the bot through which this message was sent
  int53? via_bot_user_id;

  /// For channel posts and anonymous group messages, optional author signature
  string? author_signature;

  /// Unique identifier of an album this message belongs to. Only audios, documents, photos and videos can be grouped together in albums
  int64? media_album_id;

  /// If non-empty, contains a human-readable description of the reason why access to this message must be restricted
  string? restriction_reason;

  /// Content of the message
  MessageContent? content;

  /// Reply markup for the message; may be null
  ReplyMarkup? reply_markup;

  Message({
    super.extra,
    super.client_id,
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
    this.can_report_reactions,
    this.has_timestamped_media,
    this.is_channel_post,
    this.is_topic_message,
    this.contains_unread_mention,
    this.date,
    this.edit_date,
    this.forward_info,
    this.interaction_info,
    this.unread_reactions,
    this.reply_in_chat_id,
    this.reply_to_message_id,
    this.message_thread_id,
    this.self_destruct_time,
    this.self_destruct_in,
    this.auto_delete_in,
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
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
    chat_id = map['chat_id'];
    if (map['sending_state'] != null) {
      sending_state =
          TdApiMap.fromMap(map['sending_state']) as MessageSendingState;
    }
    if (map['scheduling_state'] != null) {
      scheduling_state =
          TdApiMap.fromMap(map['scheduling_state']) as MessageSchedulingState;
    }
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
    can_report_reactions = map['can_report_reactions'];
    has_timestamped_media = map['has_timestamped_media'];
    is_channel_post = map['is_channel_post'];
    is_topic_message = map['is_topic_message'];
    contains_unread_mention = map['contains_unread_mention'];
    date = map['date'];
    edit_date = map['edit_date'];
    if (map['forward_info'] != null) {
      forward_info =
          TdApiMap.fromMap(map['forward_info']) as MessageForwardInfo;
    }
    if (map['interaction_info'] != null) {
      interaction_info =
          TdApiMap.fromMap(map['interaction_info']) as MessageInteractionInfo;
    }
    if (map['unread_reactions'] != null) {
      unread_reactions = [];
      for (var someValue in map['unread_reactions']) {
        if (someValue != null) {
          unread_reactions?.add(TdApiMap.fromMap(someValue) as UnreadReaction);
        }
      }
    }
    reply_in_chat_id = map['reply_in_chat_id'];
    reply_to_message_id = map['reply_to_message_id'];
    message_thread_id = map['message_thread_id'];
    self_destruct_time = map['self_destruct_time'];
    self_destruct_in = map['self_destruct_in'];
    auto_delete_in = map['auto_delete_in'];
    via_bot_user_id = map['via_bot_user_id'];
    author_signature = map['author_signature'];
    media_album_id = map['media_album_id'];
    restriction_reason = map['restriction_reason'];
    if (map['content'] != null) {
      content = TdApiMap.fromMap(map['content']) as MessageContent;
    }
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
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
      'can_be_deleted_only_for_self':
          can_be_deleted_only_for_self?.toMap(skipNulls: skipNulls),
      'can_be_deleted_for_all_users':
          can_be_deleted_for_all_users?.toMap(skipNulls: skipNulls),
      'can_get_added_reactions':
          can_get_added_reactions?.toMap(skipNulls: skipNulls),
      'can_get_statistics': can_get_statistics?.toMap(skipNulls: skipNulls),
      'can_get_message_thread':
          can_get_message_thread?.toMap(skipNulls: skipNulls),
      'can_get_viewers': can_get_viewers?.toMap(skipNulls: skipNulls),
      'can_get_media_timestamp_links':
          can_get_media_timestamp_links?.toMap(skipNulls: skipNulls),
      'can_report_reactions': can_report_reactions?.toMap(skipNulls: skipNulls),
      'has_timestamped_media':
          has_timestamped_media?.toMap(skipNulls: skipNulls),
      'is_channel_post': is_channel_post?.toMap(skipNulls: skipNulls),
      'is_topic_message': is_topic_message?.toMap(skipNulls: skipNulls),
      'contains_unread_mention':
          contains_unread_mention?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'edit_date': edit_date?.toMap(skipNulls: skipNulls),
      'forward_info': forward_info?.toMap(skipNulls: skipNulls),
      'interaction_info': interaction_info?.toMap(skipNulls: skipNulls),
      'unread_reactions': unread_reactions?.toMap(skipNulls: skipNulls),
      'reply_in_chat_id': reply_in_chat_id?.toMap(skipNulls: skipNulls),
      'reply_to_message_id': reply_to_message_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'self_destruct_time': self_destruct_time?.toMap(skipNulls: skipNulls),
      'self_destruct_in': self_destruct_in?.toMap(skipNulls: skipNulls),
      'auto_delete_in': auto_delete_in?.toMap(skipNulls: skipNulls),
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

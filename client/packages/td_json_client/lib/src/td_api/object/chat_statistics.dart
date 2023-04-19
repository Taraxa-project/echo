import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/date_range.dart';
import 'package:td_json_client/src/td_api/object/statistical_value.dart';
import 'package:td_json_client/src/td_api/object/statistical_graph.dart';
import 'package:td_json_client/src/td_api/object/chat_statistics_message_sender_info.dart';
import 'package:td_json_client/src/td_api/object/chat_statistics_administrator_actions_info.dart';
import 'package:td_json_client/src/td_api/object/chat_statistics_inviter_info.dart';
import 'package:td_json_client/src/td_api/object/chat_statistics_message_interaction_info.dart';

/// Contains a detailed statistics about a chat
abstract class ChatStatistics extends TdObject {
  ChatStatistics({super.extra, super.client_id});
}

/// A detailed statistics about a supergroup chat
class ChatStatisticsSupergroup extends ChatStatistics {
  String get tdType => 'chatStatisticsSupergroup';

  /// A period to which the statistics applies
  DateRange? period;

  /// Number of members in the chat
  StatisticalValue? member_count;

  /// Number of messages sent to the chat
  StatisticalValue? message_count;

  /// Number of users who viewed messages in the chat
  StatisticalValue? viewer_count;

  /// Number of users who sent messages to the chat
  StatisticalValue? sender_count;

  /// A graph containing number of members in the chat
  StatisticalGraph? member_count_graph;

  /// A graph containing number of members joined and left the chat
  StatisticalGraph? join_graph;

  /// A graph containing number of new member joins per source
  StatisticalGraph? join_by_source_graph;

  /// A graph containing distribution of active users per language
  StatisticalGraph? language_graph;

  /// A graph containing distribution of sent messages by content type
  StatisticalGraph? message_content_graph;

  /// A graph containing number of different actions in the chat
  StatisticalGraph? action_graph;

  /// A graph containing distribution of message views per hour
  StatisticalGraph? day_graph;

  /// A graph containing distribution of message views per day of week
  StatisticalGraph? week_graph;

  /// List of users sent most messages in the last week
  vector<ChatStatisticsMessageSenderInfo>? top_senders;

  /// List of most active administrators in the last week
  vector<ChatStatisticsAdministratorActionsInfo>? top_administrators;

  /// List of most active inviters of new members in the last week
  vector<ChatStatisticsInviterInfo>? top_inviters;

  ChatStatisticsSupergroup({
    super.extra,
    super.client_id,
    this.period,
    this.member_count,
    this.message_count,
    this.viewer_count,
    this.sender_count,
    this.member_count_graph,
    this.join_graph,
    this.join_by_source_graph,
    this.language_graph,
    this.message_content_graph,
    this.action_graph,
    this.day_graph,
    this.week_graph,
    this.top_senders,
    this.top_administrators,
    this.top_inviters,
  });

  ChatStatisticsSupergroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['period'] != null) {
      period = TdApiMap.fromMap(map['period']) as DateRange;
    }
    if (map['member_count'] != null) {
      member_count = TdApiMap.fromMap(map['member_count']) as StatisticalValue;
    }
    if (map['message_count'] != null) {
      message_count = TdApiMap.fromMap(map['message_count']) as StatisticalValue;
    }
    if (map['viewer_count'] != null) {
      viewer_count = TdApiMap.fromMap(map['viewer_count']) as StatisticalValue;
    }
    if (map['sender_count'] != null) {
      sender_count = TdApiMap.fromMap(map['sender_count']) as StatisticalValue;
    }
    if (map['member_count_graph'] != null) {
      member_count_graph = TdApiMap.fromMap(map['member_count_graph']) as StatisticalGraph;
    }
    if (map['join_graph'] != null) {
      join_graph = TdApiMap.fromMap(map['join_graph']) as StatisticalGraph;
    }
    if (map['join_by_source_graph'] != null) {
      join_by_source_graph = TdApiMap.fromMap(map['join_by_source_graph']) as StatisticalGraph;
    }
    if (map['language_graph'] != null) {
      language_graph = TdApiMap.fromMap(map['language_graph']) as StatisticalGraph;
    }
    if (map['message_content_graph'] != null) {
      message_content_graph = TdApiMap.fromMap(map['message_content_graph']) as StatisticalGraph;
    }
    if (map['action_graph'] != null) {
      action_graph = TdApiMap.fromMap(map['action_graph']) as StatisticalGraph;
    }
    if (map['day_graph'] != null) {
      day_graph = TdApiMap.fromMap(map['day_graph']) as StatisticalGraph;
    }
    if (map['week_graph'] != null) {
      week_graph = TdApiMap.fromMap(map['week_graph']) as StatisticalGraph;
    }
    if (map['top_senders'] != null) {
      top_senders = [];
      for (var someValue in map['top_senders']) {
        if (someValue != null) {
          top_senders?.add(TdApiMap.fromMap(someValue) as ChatStatisticsMessageSenderInfo);
        }
      }
    }
    if (map['top_administrators'] != null) {
      top_administrators = [];
      for (var someValue in map['top_administrators']) {
        if (someValue != null) {
          top_administrators?.add(TdApiMap.fromMap(someValue) as ChatStatisticsAdministratorActionsInfo);
        }
      }
    }
    if (map['top_inviters'] != null) {
      top_inviters = [];
      for (var someValue in map['top_inviters']) {
        if (someValue != null) {
          top_inviters?.add(TdApiMap.fromMap(someValue) as ChatStatisticsInviterInfo);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'period': period?.toMap(skipNulls: skipNulls),
      'member_count': member_count?.toMap(skipNulls: skipNulls),
      'message_count': message_count?.toMap(skipNulls: skipNulls),
      'viewer_count': viewer_count?.toMap(skipNulls: skipNulls),
      'sender_count': sender_count?.toMap(skipNulls: skipNulls),
      'member_count_graph': member_count_graph?.toMap(skipNulls: skipNulls),
      'join_graph': join_graph?.toMap(skipNulls: skipNulls),
      'join_by_source_graph': join_by_source_graph?.toMap(skipNulls: skipNulls),
      'language_graph': language_graph?.toMap(skipNulls: skipNulls),
      'message_content_graph': message_content_graph?.toMap(skipNulls: skipNulls),
      'action_graph': action_graph?.toMap(skipNulls: skipNulls),
      'day_graph': day_graph?.toMap(skipNulls: skipNulls),
      'week_graph': week_graph?.toMap(skipNulls: skipNulls),
      'top_senders': top_senders?.toMap(skipNulls: skipNulls),
      'top_administrators': top_administrators?.toMap(skipNulls: skipNulls),
      'top_inviters': top_inviters?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A detailed statistics about a channel chat
class ChatStatisticsChannel extends ChatStatistics {
  String get tdType => 'chatStatisticsChannel';

  /// A period to which the statistics applies
  DateRange? period;

  /// Number of members in the chat
  StatisticalValue? member_count;

  /// Mean number of times the recently sent messages was viewed
  StatisticalValue? mean_view_count;

  /// Mean number of times the recently sent messages was shared
  StatisticalValue? mean_share_count;

  /// A percentage of users with enabled notifications for the chat
  double? enabled_notifications_percentage;

  /// A graph containing number of members in the chat
  StatisticalGraph? member_count_graph;

  /// A graph containing number of members joined and left the chat
  StatisticalGraph? join_graph;

  /// A graph containing number of members muted and unmuted the chat
  StatisticalGraph? mute_graph;

  /// A graph containing number of message views in a given hour in the last two weeks
  StatisticalGraph? view_count_by_hour_graph;

  /// A graph containing number of message views per source
  StatisticalGraph? view_count_by_source_graph;

  /// A graph containing number of new member joins per source
  StatisticalGraph? join_by_source_graph;

  /// A graph containing number of users viewed chat messages per language
  StatisticalGraph? language_graph;

  /// A graph containing number of chat message views and shares
  StatisticalGraph? message_interaction_graph;

  /// A graph containing number of views of associated with the chat instant views
  StatisticalGraph? instant_view_interaction_graph;

  /// Detailed statistics about number of views and shares of recently sent messages
  vector<ChatStatisticsMessageInteractionInfo>? recent_message_interactions;

  ChatStatisticsChannel({
    super.extra,
    super.client_id,
    this.period,
    this.member_count,
    this.mean_view_count,
    this.mean_share_count,
    this.enabled_notifications_percentage,
    this.member_count_graph,
    this.join_graph,
    this.mute_graph,
    this.view_count_by_hour_graph,
    this.view_count_by_source_graph,
    this.join_by_source_graph,
    this.language_graph,
    this.message_interaction_graph,
    this.instant_view_interaction_graph,
    this.recent_message_interactions,
  });

  ChatStatisticsChannel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['period'] != null) {
      period = TdApiMap.fromMap(map['period']) as DateRange;
    }
    if (map['member_count'] != null) {
      member_count = TdApiMap.fromMap(map['member_count']) as StatisticalValue;
    }
    if (map['mean_view_count'] != null) {
      mean_view_count = TdApiMap.fromMap(map['mean_view_count']) as StatisticalValue;
    }
    if (map['mean_share_count'] != null) {
      mean_share_count = TdApiMap.fromMap(map['mean_share_count']) as StatisticalValue;
    }
    enabled_notifications_percentage = map['enabled_notifications_percentage'];
    if (map['member_count_graph'] != null) {
      member_count_graph = TdApiMap.fromMap(map['member_count_graph']) as StatisticalGraph;
    }
    if (map['join_graph'] != null) {
      join_graph = TdApiMap.fromMap(map['join_graph']) as StatisticalGraph;
    }
    if (map['mute_graph'] != null) {
      mute_graph = TdApiMap.fromMap(map['mute_graph']) as StatisticalGraph;
    }
    if (map['view_count_by_hour_graph'] != null) {
      view_count_by_hour_graph = TdApiMap.fromMap(map['view_count_by_hour_graph']) as StatisticalGraph;
    }
    if (map['view_count_by_source_graph'] != null) {
      view_count_by_source_graph = TdApiMap.fromMap(map['view_count_by_source_graph']) as StatisticalGraph;
    }
    if (map['join_by_source_graph'] != null) {
      join_by_source_graph = TdApiMap.fromMap(map['join_by_source_graph']) as StatisticalGraph;
    }
    if (map['language_graph'] != null) {
      language_graph = TdApiMap.fromMap(map['language_graph']) as StatisticalGraph;
    }
    if (map['message_interaction_graph'] != null) {
      message_interaction_graph = TdApiMap.fromMap(map['message_interaction_graph']) as StatisticalGraph;
    }
    if (map['instant_view_interaction_graph'] != null) {
      instant_view_interaction_graph = TdApiMap.fromMap(map['instant_view_interaction_graph']) as StatisticalGraph;
    }
    if (map['recent_message_interactions'] != null) {
      recent_message_interactions = [];
      for (var someValue in map['recent_message_interactions']) {
        if (someValue != null) {
          recent_message_interactions?.add(TdApiMap.fromMap(someValue) as ChatStatisticsMessageInteractionInfo);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'period': period?.toMap(skipNulls: skipNulls),
      'member_count': member_count?.toMap(skipNulls: skipNulls),
      'mean_view_count': mean_view_count?.toMap(skipNulls: skipNulls),
      'mean_share_count': mean_share_count?.toMap(skipNulls: skipNulls),
      'enabled_notifications_percentage': enabled_notifications_percentage?.toMap(skipNulls: skipNulls),
      'member_count_graph': member_count_graph?.toMap(skipNulls: skipNulls),
      'join_graph': join_graph?.toMap(skipNulls: skipNulls),
      'mute_graph': mute_graph?.toMap(skipNulls: skipNulls),
      'view_count_by_hour_graph': view_count_by_hour_graph?.toMap(skipNulls: skipNulls),
      'view_count_by_source_graph': view_count_by_source_graph?.toMap(skipNulls: skipNulls),
      'join_by_source_graph': join_by_source_graph?.toMap(skipNulls: skipNulls),
      'language_graph': language_graph?.toMap(skipNulls: skipNulls),
      'message_interaction_graph': message_interaction_graph?.toMap(skipNulls: skipNulls),
      'instant_view_interaction_graph': instant_view_interaction_graph?.toMap(skipNulls: skipNulls),
      'recent_message_interactions': recent_message_interactions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

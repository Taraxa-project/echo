import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/date_range.dart';
import 'package:td_json_client/api/object/statistical_value.dart';
import 'package:td_json_client/api/object/statistical_graph.dart';
import 'package:td_json_client/api/object/chat_statistics_message_sender_info.dart';
import 'package:td_json_client/api/object/chat_statistics_administrator_actions_info.dart';
import 'package:td_json_client/api/object/chat_statistics_inviter_info.dart';
import 'package:td_json_client/api/object/chat_statistics_message_interaction_info.dart';

abstract class ChatStatistics extends TdObject {}

class ChatStatisticsSupergroup extends ChatStatistics {
  String get tdType => 'chatStatisticsSupergroup';

  string? extra;
  int? client_id;
  DateRange? period;
  StatisticalValue? member_count;
  StatisticalValue? message_count;
  StatisticalValue? viewer_count;
  StatisticalValue? sender_count;
  StatisticalGraph? member_count_graph;
  StatisticalGraph? join_graph;
  StatisticalGraph? join_by_source_graph;
  StatisticalGraph? language_graph;
  StatisticalGraph? message_content_graph;
  StatisticalGraph? action_graph;
  StatisticalGraph? day_graph;
  StatisticalGraph? week_graph;
  vector<ChatStatisticsMessageSenderInfo>? top_senders;
  vector<ChatStatisticsAdministratorActionsInfo>? top_administrators;
  vector<ChatStatisticsInviterInfo>? top_inviters;

  ChatStatisticsSupergroup({
    this.extra,
    this.client_id,
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
    period = TdApiMap.fromMap(map['period']) as DateRange;
    member_count = TdApiMap.fromMap(map['member_count']) as StatisticalValue;
    message_count = TdApiMap.fromMap(map['message_count']) as StatisticalValue;
    viewer_count = TdApiMap.fromMap(map['viewer_count']) as StatisticalValue;
    sender_count = TdApiMap.fromMap(map['sender_count']) as StatisticalValue;
    member_count_graph = TdApiMap.fromMap(map['member_count_graph']) as StatisticalGraph;
    join_graph = TdApiMap.fromMap(map['join_graph']) as StatisticalGraph;
    join_by_source_graph = TdApiMap.fromMap(map['join_by_source_graph']) as StatisticalGraph;
    language_graph = TdApiMap.fromMap(map['language_graph']) as StatisticalGraph;
    message_content_graph = TdApiMap.fromMap(map['message_content_graph']) as StatisticalGraph;
    action_graph = TdApiMap.fromMap(map['action_graph']) as StatisticalGraph;
    day_graph = TdApiMap.fromMap(map['day_graph']) as StatisticalGraph;
    week_graph = TdApiMap.fromMap(map['week_graph']) as StatisticalGraph;
    if (map['top_senders']) {
      top_senders = [];
      for (var someValue in map['top_senders']) {
        top_senders?.add(TdApiMap.fromMap(someValue) as ChatStatisticsMessageSenderInfo);
      }
    }
    if (map['top_administrators']) {
      top_administrators = [];
      for (var someValue in map['top_administrators']) {
        top_administrators?.add(TdApiMap.fromMap(someValue) as ChatStatisticsAdministratorActionsInfo);
      }
    }
    if (map['top_inviters']) {
      top_inviters = [];
      for (var someValue in map['top_inviters']) {
        top_inviters?.add(TdApiMap.fromMap(someValue) as ChatStatisticsInviterInfo);
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
class ChatStatisticsChannel extends ChatStatistics {
  String get tdType => 'chatStatisticsChannel';

  string? extra;
  int? client_id;
  DateRange? period;
  StatisticalValue? member_count;
  StatisticalValue? mean_view_count;
  StatisticalValue? mean_share_count;
  double? enabled_notifications_percentage;
  StatisticalGraph? member_count_graph;
  StatisticalGraph? join_graph;
  StatisticalGraph? mute_graph;
  StatisticalGraph? view_count_by_hour_graph;
  StatisticalGraph? view_count_by_source_graph;
  StatisticalGraph? join_by_source_graph;
  StatisticalGraph? language_graph;
  StatisticalGraph? message_interaction_graph;
  StatisticalGraph? instant_view_interaction_graph;
  vector<ChatStatisticsMessageInteractionInfo>? recent_message_interactions;

  ChatStatisticsChannel({
    this.extra,
    this.client_id,
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
    period = TdApiMap.fromMap(map['period']) as DateRange;
    member_count = TdApiMap.fromMap(map['member_count']) as StatisticalValue;
    mean_view_count = TdApiMap.fromMap(map['mean_view_count']) as StatisticalValue;
    mean_share_count = TdApiMap.fromMap(map['mean_share_count']) as StatisticalValue;
    enabled_notifications_percentage = map['enabled_notifications_percentage'];
    member_count_graph = TdApiMap.fromMap(map['member_count_graph']) as StatisticalGraph;
    join_graph = TdApiMap.fromMap(map['join_graph']) as StatisticalGraph;
    mute_graph = TdApiMap.fromMap(map['mute_graph']) as StatisticalGraph;
    view_count_by_hour_graph = TdApiMap.fromMap(map['view_count_by_hour_graph']) as StatisticalGraph;
    view_count_by_source_graph = TdApiMap.fromMap(map['view_count_by_source_graph']) as StatisticalGraph;
    join_by_source_graph = TdApiMap.fromMap(map['join_by_source_graph']) as StatisticalGraph;
    language_graph = TdApiMap.fromMap(map['language_graph']) as StatisticalGraph;
    message_interaction_graph = TdApiMap.fromMap(map['message_interaction_graph']) as StatisticalGraph;
    instant_view_interaction_graph = TdApiMap.fromMap(map['instant_view_interaction_graph']) as StatisticalGraph;
    if (map['recent_message_interactions']) {
      recent_message_interactions = [];
      for (var someValue in map['recent_message_interactions']) {
        recent_message_interactions?.add(TdApiMap.fromMap(someValue) as ChatStatisticsMessageInteractionInfo);
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

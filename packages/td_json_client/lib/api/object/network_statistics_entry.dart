import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file_type.dart';
import 'package:td_json_client/api/object/network_type.dart';

/// Contains statistics about network usage
abstract class NetworkStatisticsEntry extends TdObject {}


/// Contains information about the total amount of data that was used to send and receive files
class NetworkStatisticsEntryFile extends NetworkStatisticsEntry {
  String get tdType => 'networkStatisticsEntryFile';

  String? extra;
  int? client_id;

  /// Type of the file the data is part of; pass null if the data isn't related to files
  FileType? file_type;

  /// Type of the network the data was sent through. Call setNetworkType to maintain the actual network type
  NetworkType? network_type;

  /// Total number of bytes sent 
  int53? sent_bytes;

  /// Total number of bytes received
  int53? received_bytes;

  NetworkStatisticsEntryFile({
    this.extra,
    this.client_id,
    this.file_type,
    this.network_type,
    this.sent_bytes,
    this.received_bytes,
  });

  NetworkStatisticsEntryFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_type = TdApiMap.fromMap(map['file_type']) as FileType;
    network_type = TdApiMap.fromMap(map['network_type']) as NetworkType;
    sent_bytes = map['sent_bytes'];
    received_bytes = map['received_bytes'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_type': file_type?.toMap(skipNulls: skipNulls),
      'network_type': network_type?.toMap(skipNulls: skipNulls),
      'sent_bytes': sent_bytes?.toMap(skipNulls: skipNulls),
      'received_bytes': received_bytes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Contains information about the total amount of data that was used for calls
class NetworkStatisticsEntryCall extends NetworkStatisticsEntry {
  String get tdType => 'networkStatisticsEntryCall';

  String? extra;
  int? client_id;

  /// Type of the network the data was sent through. Call setNetworkType to maintain the actual network type
  NetworkType? network_type;

  /// Total number of bytes sent
  int53? sent_bytes;

  /// Total number of bytes received
  int53? received_bytes;

  /// Total call duration, in seconds
  double? duration;

  NetworkStatisticsEntryCall({
    this.extra,
    this.client_id,
    this.network_type,
    this.sent_bytes,
    this.received_bytes,
    this.duration,
  });

  NetworkStatisticsEntryCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    network_type = TdApiMap.fromMap(map['network_type']) as NetworkType;
    sent_bytes = map['sent_bytes'];
    received_bytes = map['received_bytes'];
    duration = map['duration'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'network_type': network_type?.toMap(skipNulls: skipNulls),
      'sent_bytes': sent_bytes?.toMap(skipNulls: skipNulls),
      'received_bytes': received_bytes?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

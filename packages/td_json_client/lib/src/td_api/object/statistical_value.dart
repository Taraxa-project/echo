import 'package:td_json_client/src/td_api/td.dart';

/// A value with information about its recent changes
class StatisticalValue extends TdObject {
  String get tdType => 'statisticalValue';

  /// The current value
  double? value;

  /// The value for the previous day
  double? previous_value;

  /// The growth rate of the value, as a percentage
  double? growth_rate_percentage;

  StatisticalValue({
    super.extra,
    super.client_id,
    this.value,
    this.previous_value,
    this.growth_rate_percentage,
  });

  StatisticalValue.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    value = map['value'];
    previous_value = map['previous_value'];
    growth_rate_percentage = map['growth_rate_percentage'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
      'previous_value': previous_value?.toMap(skipNulls: skipNulls),
      'growth_rate_percentage': growth_rate_percentage?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

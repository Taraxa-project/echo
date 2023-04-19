import 'package:td_json_client/src/td_api/td.dart';

/// Represents the value of an option
abstract class OptionValue extends TdObject {
  OptionValue({super.extra, super.client_id});
}

/// Represents a boolean option
class OptionValueBoolean extends OptionValue {
  String get tdType => 'optionValueBoolean';

  /// The value of the option
  Bool? value;

  OptionValueBoolean({
    super.extra,
    super.client_id,
    this.value,
  });

  OptionValueBoolean.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    value = map['value'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents an unknown option or an option which has a default value
class OptionValueEmpty extends OptionValue {
  String get tdType => 'optionValueEmpty';

  OptionValueEmpty({
    super.extra,
    super.client_id,
  });

  OptionValueEmpty.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents an integer option
class OptionValueInteger extends OptionValue {
  String get tdType => 'optionValueInteger';

  /// The value of the option
  int64? value;

  OptionValueInteger({
    super.extra,
    super.client_id,
    this.value,
  });

  OptionValueInteger.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    value = map['value'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents a string option
class OptionValueString extends OptionValue {
  String get tdType => 'optionValueString';

  /// The value of the option
  string? value;

  OptionValueString({
    super.extra,
    super.client_id,
    this.value,
  });

  OptionValueString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    value = map['value'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

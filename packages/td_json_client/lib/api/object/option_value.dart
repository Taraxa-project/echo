import 'package:td_json_client/api/base.dart';

abstract class OptionValue extends TdObject {}

class OptionValueBoolean extends OptionValue {
  String get tdType => 'optionValueBoolean';

  String? extra;
  int? client_id;
  Bool? value;

  OptionValueBoolean({
    this.extra,
    this.client_id,
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
class OptionValueEmpty extends OptionValue {
  String get tdType => 'optionValueEmpty';

  String? extra;
  int? client_id;

  OptionValueEmpty({
    this.extra,
    this.client_id,
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
class OptionValueInteger extends OptionValue {
  String get tdType => 'optionValueInteger';

  String? extra;
  int? client_id;
  int64? value;

  OptionValueInteger({
    this.extra,
    this.client_id,
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
class OptionValueString extends OptionValue {
  String get tdType => 'optionValueString';

  String? extra;
  int? client_id;
  string? value;

  OptionValueString({
    this.extra,
    this.client_id,
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

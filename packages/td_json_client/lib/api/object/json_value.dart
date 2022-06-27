import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/json_object_member.dart';

abstract class JsonValue extends TdObject {}

class JsonValueNull extends JsonValue {
  String get tdType => 'jsonValueNull';

  string? extra;
  int? client_id;

  JsonValueNull({
    this.extra,
    this.client_id,
  });

  JsonValueNull.fromMap(Map<String, dynamic> map) {
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
class JsonValueBoolean extends JsonValue {
  String get tdType => 'jsonValueBoolean';

  string? extra;
  int? client_id;
  Bool? value;

  JsonValueBoolean({
    this.extra,
    this.client_id,
    this.value,
  });

  JsonValueBoolean.fromMap(Map<String, dynamic> map) {
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
class JsonValueNumber extends JsonValue {
  String get tdType => 'jsonValueNumber';

  string? extra;
  int? client_id;
  double? value;

  JsonValueNumber({
    this.extra,
    this.client_id,
    this.value,
  });

  JsonValueNumber.fromMap(Map<String, dynamic> map) {
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
class JsonValueString extends JsonValue {
  String get tdType => 'jsonValueString';

  string? extra;
  int? client_id;
  string? value;

  JsonValueString({
    this.extra,
    this.client_id,
    this.value,
  });

  JsonValueString.fromMap(Map<String, dynamic> map) {
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
class JsonValueArray extends JsonValue {
  String get tdType => 'jsonValueArray';

  string? extra;
  int? client_id;
  vector<JsonValue>? values;

  JsonValueArray({
    this.extra,
    this.client_id,
    this.values,
  });

  JsonValueArray.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['values']) {
      values = [];
      for (var someValue in map['values']) {
        values?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'values': values?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class JsonValueObject extends JsonValue {
  String get tdType => 'jsonValueObject';

  string? extra;
  int? client_id;
  vector<JsonObjectMember>? members;

  JsonValueObject({
    this.extra,
    this.client_id,
    this.members,
  });

  JsonValueObject.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['members']) {
      members = [];
      for (var someValue in map['members']) {
        members?.add(TdApiMap.fromMap(someValue) as JsonObjectMember);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'members': members?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

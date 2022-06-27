import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/json_object_member.dart';

/// Represents a JSON value
abstract class JsonValue extends TdObject {}


/// Represents a null JSON value
class JsonValueNull extends JsonValue {
  String get tdType => 'jsonValueNull';

  String? extra;
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

/// Represents a boolean JSON value 
class JsonValueBoolean extends JsonValue {
  String get tdType => 'jsonValueBoolean';

  String? extra;
  int? client_id;

  /// The value
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

/// Represents a numeric JSON value 
class JsonValueNumber extends JsonValue {
  String get tdType => 'jsonValueNumber';

  String? extra;
  int? client_id;

  /// The value
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

/// Represents a string JSON value 
class JsonValueString extends JsonValue {
  String get tdType => 'jsonValueString';

  String? extra;
  int? client_id;

  /// The value
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

/// Represents a JSON array 
class JsonValueArray extends JsonValue {
  String get tdType => 'jsonValueArray';

  String? extra;
  int? client_id;

  /// The list of array elements
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

/// Represents a JSON object 
class JsonValueObject extends JsonValue {
  String get tdType => 'jsonValueObject';

  String? extra;
  int? client_id;

  /// The list of object members
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

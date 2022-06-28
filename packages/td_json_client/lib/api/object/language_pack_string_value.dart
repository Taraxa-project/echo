import 'package:td_json_client/api/base.dart';

/// Represents the value of a string in a language pack
abstract class LanguagePackStringValue extends TdObject {}


/// An ordinary language pack string 
class LanguagePackStringValueOrdinary extends LanguagePackStringValue {
  String get tdType => 'languagePackStringValueOrdinary';

  String? extra;
  int? client_id;

  /// String value
  string? value;

  LanguagePackStringValueOrdinary({
    this.extra,
    this.client_id,
    this.value,
  });

  LanguagePackStringValueOrdinary.fromMap(Map<String, dynamic> map) {
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

/// A language pack string which has different forms based on the number of some object it mentions. See https://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html for more information
class LanguagePackStringValuePluralized extends LanguagePackStringValue {
  String get tdType => 'languagePackStringValuePluralized';

  String? extra;
  int? client_id;

  /// Value for zero objects 
  string? zero_value;

  /// Value for one object 
  string? one_value;

  /// Value for two objects
  string? two_value;

  /// Value for few objects 
  string? few_value;

  /// Value for many objects 
  string? many_value;

  /// Default value
  string? other_value;

  LanguagePackStringValuePluralized({
    this.extra,
    this.client_id,
    this.zero_value,
    this.one_value,
    this.two_value,
    this.few_value,
    this.many_value,
    this.other_value,
  });

  LanguagePackStringValuePluralized.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    zero_value = map['zero_value'];
    one_value = map['one_value'];
    two_value = map['two_value'];
    few_value = map['few_value'];
    many_value = map['many_value'];
    other_value = map['other_value'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'zero_value': zero_value?.toMap(skipNulls: skipNulls),
      'one_value': one_value?.toMap(skipNulls: skipNulls),
      'two_value': two_value?.toMap(skipNulls: skipNulls),
      'few_value': few_value?.toMap(skipNulls: skipNulls),
      'many_value': many_value?.toMap(skipNulls: skipNulls),
      'other_value': other_value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A deleted language pack string, the value must be taken from the built-in English language pack
class LanguagePackStringValueDeleted extends LanguagePackStringValue {
  String get tdType => 'languagePackStringValueDeleted';

  String? extra;
  int? client_id;

  LanguagePackStringValueDeleted({
    this.extra,
    this.client_id,
  });

  LanguagePackStringValueDeleted.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/keyboard_button.dart';
import 'package:td_json_client/api/object/inline_keyboard_button.dart';

abstract class ReplyMarkup extends TdObject {}

class ReplyMarkupRemoveKeyboard extends ReplyMarkup {
  String get tdType => 'replyMarkupRemoveKeyboard';

  string? extra;
  int? client_id;
  Bool? is_personal;

  ReplyMarkupRemoveKeyboard({
    this.extra,
    this.client_id,
    this.is_personal,
  });

  ReplyMarkupRemoveKeyboard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_personal = map['is_personal'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_personal': is_personal?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ReplyMarkupForceReply extends ReplyMarkup {
  String get tdType => 'replyMarkupForceReply';

  string? extra;
  int? client_id;
  Bool? is_personal;
  string? input_field_placeholder;

  ReplyMarkupForceReply({
    this.extra,
    this.client_id,
    this.is_personal,
    this.input_field_placeholder,
  });

  ReplyMarkupForceReply.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_personal = map['is_personal'];
    input_field_placeholder = map['input_field_placeholder'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_personal': is_personal?.toMap(skipNulls: skipNulls),
      'input_field_placeholder': input_field_placeholder?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ReplyMarkupShowKeyboard extends ReplyMarkup {
  String get tdType => 'replyMarkupShowKeyboard';

  string? extra;
  int? client_id;
  vector<vector<KeyboardButton>>? rows;
  Bool? resize_keyboard;
  Bool? one_time;
  Bool? is_personal;
  string? input_field_placeholder;

  ReplyMarkupShowKeyboard({
    this.extra,
    this.client_id,
    this.rows,
    this.resize_keyboard,
    this.one_time,
    this.is_personal,
    this.input_field_placeholder,
  });

  ReplyMarkupShowKeyboard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['rows']) {
      rows = [];
      for (var someValues in map['rows']) {
        var objs = <KeyboardButton>[];
        for (var someValue in someValues) {
          objs.add(TdApiMap.fromMap(someValue) as KeyboardButton);
        }
        rows?.add(objs);
      }
    }
    resize_keyboard = map['resize_keyboard'];
    one_time = map['one_time'];
    is_personal = map['is_personal'];
    input_field_placeholder = map['input_field_placeholder'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'rows': rows?.toMap(skipNulls: skipNulls),
      'resize_keyboard': resize_keyboard?.toMap(skipNulls: skipNulls),
      'one_time': one_time?.toMap(skipNulls: skipNulls),
      'is_personal': is_personal?.toMap(skipNulls: skipNulls),
      'input_field_placeholder': input_field_placeholder?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ReplyMarkupInlineKeyboard extends ReplyMarkup {
  String get tdType => 'replyMarkupInlineKeyboard';

  string? extra;
  int? client_id;
  vector<vector<InlineKeyboardButton>>? rows;

  ReplyMarkupInlineKeyboard({
    this.extra,
    this.client_id,
    this.rows,
  });

  ReplyMarkupInlineKeyboard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['rows']) {
      rows = [];
      for (var someValues in map['rows']) {
        var objs = <InlineKeyboardButton>[];
        for (var someValue in someValues) {
          objs.add(TdApiMap.fromMap(someValue) as InlineKeyboardButton);
        }
        rows?.add(objs);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'rows': rows?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

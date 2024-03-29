import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/keyboard_button.dart';
import 'package:td_json_client/src/td_api/object/inline_keyboard_button.dart';

/// Contains a description of a custom keyboard and actions that can be done with it to quickly reply to bots
abstract class ReplyMarkup extends TdObject {
  ReplyMarkup({super.extra, super.client_id});
}

/// Instructs application to remove the keyboard once this message has been received. This kind of keyboard can't be received in an incoming message; instead, updateChatReplyMarkup with message_id == 0 will be sent
class ReplyMarkupRemoveKeyboard extends ReplyMarkup {
  String get tdType => 'replyMarkupRemoveKeyboard';

  /// True, if the keyboard is removed only for the mentioned users or the target user of a reply
  Bool? is_personal;

  ReplyMarkupRemoveKeyboard({
    super.extra,
    super.client_id,
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

/// Instructs application to force a reply to this message
class ReplyMarkupForceReply extends ReplyMarkup {
  String get tdType => 'replyMarkupForceReply';

  /// True, if a forced reply must automatically be shown to the current user. For outgoing messages, specify true to show the forced reply only for the mentioned users and for the target user of a reply
  Bool? is_personal;

  /// If non-empty, the placeholder to be shown in the input field when the reply is active; 0-64 characters
  string? input_field_placeholder;

  ReplyMarkupForceReply({
    super.extra,
    super.client_id,
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

/// Contains a custom keyboard layout to quickly reply to bots
class ReplyMarkupShowKeyboard extends ReplyMarkup {
  String get tdType => 'replyMarkupShowKeyboard';

  /// A list of rows of bot keyboard buttons
  vector<vector<KeyboardButton>>? rows;

  /// True, if the keyboard is supposed to always be shown when the ordinary keyboard is hidden
  Bool? is_persistent;

  /// True, if the application needs to resize the keyboard vertically
  Bool? resize_keyboard;

  /// True, if the application needs to hide the keyboard after use
  Bool? one_time;

  /// True, if the keyboard must automatically be shown to the current user. For outgoing messages, specify true to show the keyboard only for the mentioned users and for the target user of a reply
  Bool? is_personal;

  /// If non-empty, the placeholder to be shown in the input field when the keyboard is active; 0-64 characters
  string? input_field_placeholder;

  ReplyMarkupShowKeyboard({
    super.extra,
    super.client_id,
    this.rows,
    this.is_persistent,
    this.resize_keyboard,
    this.one_time,
    this.is_personal,
    this.input_field_placeholder,
  });

  ReplyMarkupShowKeyboard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['rows'] != null) {
      rows = [];
      for (var someValues in map['rows']) {
        var objs = <KeyboardButton>[];
        for (var someValue in someValues) {
          if (someValue != null) {
            objs.add(TdApiMap.fromMap(someValue) as KeyboardButton);
          }
        }
        rows?.add(objs);
      }
    }
    is_persistent = map['is_persistent'];
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
      'is_persistent': is_persistent?.toMap(skipNulls: skipNulls),
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

/// Contains an inline keyboard layout
class ReplyMarkupInlineKeyboard extends ReplyMarkup {
  String get tdType => 'replyMarkupInlineKeyboard';

  /// A list of rows of inline keyboard buttons
  vector<vector<InlineKeyboardButton>>? rows;

  ReplyMarkupInlineKeyboard({
    super.extra,
    super.client_id,
    this.rows,
  });

  ReplyMarkupInlineKeyboard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['rows'] != null) {
      rows = [];
      for (var someValues in map['rows']) {
        var objs = <InlineKeyboardButton>[];
        for (var someValue in someValues) {
          if (someValue != null) {
            objs.add(TdApiMap.fromMap(someValue) as InlineKeyboardButton);
          }
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

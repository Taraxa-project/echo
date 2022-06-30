import 'package:td_json_client/api/base.dart';

/// Describes a keyboard button type
abstract class KeyboardButtonType extends TdObject {
  KeyboardButtonType({super.extra, super.client_id});
}


/// A simple button, with text that must be sent when the button is pressed
class KeyboardButtonTypeText extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeText';


  KeyboardButtonTypeText({
    super.extra,
    super.client_id,
  });

  KeyboardButtonTypeText.fromMap(Map<String, dynamic> map) {
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

/// A button that sends the user's phone number when pressed; available only in private chats
class KeyboardButtonTypeRequestPhoneNumber extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestPhoneNumber';


  KeyboardButtonTypeRequestPhoneNumber({
    super.extra,
    super.client_id,
  });

  KeyboardButtonTypeRequestPhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// A button that sends the user's location when pressed; available only in private chats
class KeyboardButtonTypeRequestLocation extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestLocation';


  KeyboardButtonTypeRequestLocation({
    super.extra,
    super.client_id,
  });

  KeyboardButtonTypeRequestLocation.fromMap(Map<String, dynamic> map) {
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

/// A button that allows the user to create and send a poll when pressed; available only in private chats 
class KeyboardButtonTypeRequestPoll extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestPoll';


  /// If true, only regular polls must be allowed to create 
  Bool? force_regular;

  /// If true, only polls in quiz mode must be allowed to create
  Bool? force_quiz;

  KeyboardButtonTypeRequestPoll({
    super.extra,
    super.client_id,
    this.force_regular,
    this.force_quiz,
  });

  KeyboardButtonTypeRequestPoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    force_regular = map['force_regular'];
    force_quiz = map['force_quiz'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'force_regular': force_regular?.toMap(skipNulls: skipNulls),
      'force_quiz': force_quiz?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

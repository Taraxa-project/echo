import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

import 'base.dart';

class NewMesssages extends TelegramEventListener {
  @override
  void update(dynamic event) {
    if (event is UpdateNewMessage) {
      _onUpdateNewMessage(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  void _onUpdateNewMessage(UpdateNewMessage updateNewMessage) {
    var content = updateNewMessage.message?.content;
    if (content is MessageText && content.text is FormattedText) {
      print(
          '[${Isolate.current.debugName}._onUpdateNewMessage] ${content.text?.text}');
    }
  }

  void _onError(Error error) {
    print(error);
  }

  static Future<NewMesssagesIsolated> isolate() async {
    NewMesssagesIsolated instance = NewMesssagesIsolated();
    await instance.spawn();
    return instance;
  }
}

class NewMesssagesIsolated extends NewMesssages with Isolated {
  NewMesssagesIsolated() {
    init(instance: NewMesssages());
  }
}

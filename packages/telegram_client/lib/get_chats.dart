import 'package:td_json_client/td_json_client.dart';

import 'isolated.dart';

class GetChatList extends IsolatedSubscriber {
  static Future<GetChatList> create() async {
    final getChats = GetChatList._create();
    await getChats.spawn();
    return getChats;
  }

  GetChatList._create() {}

  @override
  void onSubscribedMessage(SubscribedMessage isolateMessage) {
    publisherReceivePortBroadcast
        ?.where((message) =>
            message is TdObjectMessage &&
            message.td is UpdateSupergroupFullInfo)
        .listen((event) {
      onUpdateSupergroupFullInfo(event.td);
    });

    publisherReceivePortBroadcast
        ?.where((message) =>
            message is TdObjectMessage &&
            message.td is UpdateBasicGroupFullInfo)
        .listen((event) {
      onUpdateBasicGroupFullInfo(event.td);
    });

    publisherReceivePortBroadcast
        ?.where((message) =>
            message is TdObjectMessage && message.td is UpdateUserFullInfo)
        .listen((event) {
      onUpdateUserFullInfo(event.td);
    });

    publisherReceivePortBroadcast
        ?.where((message) => message is TdObjectMessage && message.td is Error)
        .listen((event) {
      onError(event.td);
    });

    publisherSendPort.send(TdFunctionMessage(
      td: GetChats(limit: 100),
    ));
  }

  void onUpdateSupergroupFullInfo(
      UpdateSupergroupFullInfo updateSupergroupFullInfo) {
    print(updateSupergroupFullInfo);
  }

  void onUpdateBasicGroupFullInfo(
      UpdateBasicGroupFullInfo updateBasicGroupFullInfo) {
    print(updateBasicGroupFullInfo);
  }

  void onUpdateUserFullInfo(UpdateUserFullInfo updateUserFullInfo) {
    print(updateUserFullInfo);
  }

  void onError(Error error) {
    print(error);
  }
}

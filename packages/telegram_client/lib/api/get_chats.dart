import 'package:td_json_client/td_json_client.dart';

import 'base.dart';

class GetChatsRequest extends Request {
  final GetChats getChats;

  GetChatsRequest({
    required this.getChats,
  });

  @override
  Future<GetChatsResponse> execute(
    TdJsonClient tdJsonClient,
    int clientId, {
    double waitTimeout = 10.0,
  }) async {
    await tdJsonClient.send(clientId, getChats);

    return GetChatsResponse(
        chats: tdJsonClient
            .receive(waitTimeout: waitTimeout)
            .where((event) =>
                event is UpdateSupergroupFullInfo ||
                event is UpdateBasicGroupFullInfo ||
                event is UpdateUserFullInfo ||
                event is Error)
            .takeWhile(
                (element) => !(element is Error && element.code == 404)));
  }
}

class GetChatsResponse extends Response {
  Stream<dynamic> chats;
  GetChatsResponse({required this.chats});
}

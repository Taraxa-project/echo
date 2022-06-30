import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/request/request.dart';

class GetChatsRequest extends Request {
  final GetChats getChats;

  GetChatsRequest({
    required this.getChats,
  });

  @override
  Stream<dynamic> execute(
    TdJsonClient tdJsonClient,
    int clientId, {
    double waitTimeout = 10.0,
  }) async* {
    await tdJsonClient.send(clientId, getChats);

    await for (var response in tdJsonClient
        .receive(waitTimeout: waitTimeout)
        .where((event) =>
            event is UpdateSupergroupFullInfo ||
            event is UpdateBasicGroupFullInfo ||
            event is UpdateUserFullInfo)) {
      yield response;
    }
  }
}

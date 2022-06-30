import 'package:loggy/loggy.dart';

import 'package:td_json_client/td_json_client.dart';

mixin RequestLoggy implements LoggyType {
  @override
  Loggy<RequestLoggy> get loggy => Loggy<RequestLoggy>('$runtimeType');
}

abstract class Request with RequestLoggy {
  void execute(TdJsonClient tdJsonClient, int clientId);
}

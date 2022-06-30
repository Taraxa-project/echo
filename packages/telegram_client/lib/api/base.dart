import 'package:loggy/loggy.dart';

import 'package:td_json_client/td_json_client.dart';

mixin RequestLoggy implements LoggyType {
  @override
  Loggy<ResponseLoggy> get loggy => Loggy<ResponseLoggy>('$runtimeType');
}

mixin ResponseLoggy implements LoggyType {
  @override
  Loggy<ResponseLoggy> get loggy => Loggy<ResponseLoggy>('$runtimeType');
}

abstract class Request with ResponseLoggy {
  dynamic execute(TdJsonClient tdJsonClient, int clientId);
}

abstract class Response with ResponseLoggy {}

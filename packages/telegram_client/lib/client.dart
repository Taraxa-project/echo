import 'package:loggy/loggy.dart';

import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/request/request.dart';

mixin TelegramClientLoggy implements LoggyType {
  @override
  Loggy<TelegramClientLoggy> get loggy =>
      Loggy<TelegramClientLoggy>('$runtimeType');

  void setLogLevel(String logLevelName) {
    loggy.level = LogOptions(LogLevel.values.firstWhere(
        (element) => element.name == logLevelName,
        orElse: () => LogLevel.all));
  }
}

class TelegramClient with TelegramClientLoggy {
  late final TdJsonClient _tdJsonClient;
  TdJsonClient get tdJsonClient => _tdJsonClient;
  late final int _clientId;

  static const double waitTimeout = 10.0;

  TelegramClient({
    required String libtdjsonPath,
    int libtdjsonLoglevel = 1,
    loglevel = 'Error',
  }) {
    _tdJsonClient = TdJsonClient(
        libtdjsonPath: libtdjsonPath,
        libtdjsonLoglevel: libtdjsonLoglevel,
        loglevel: loglevel);
    _clientId = _tdJsonClient.create_client_id();
    setLogLevel(loglevel);
  }

  Future<void> send(Request request) async {
    request.execute(_tdJsonClient, _clientId);
  }
}

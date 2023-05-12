import 'dart:async';

import 'package:td_json_client/td_api.dart';

abstract class TgInterface {
  FutureOr<void> close();
  FutureOr<void> login(
    int apiId,
    String apiHash,
    String phoneNumber,
    String databasePath,
    String Function() readTelegramCode,
    void Function(String) writeQrCodeLink,
    String Function() readUserFirstName,
    String Function() readUserLastName,
    String Function() readUserPassword,
  );
  FutureOr<void> saveChatsHistory();
}

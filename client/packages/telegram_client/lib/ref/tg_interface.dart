import 'dart:async';

import 'package:td_json_client/td_api.dart';

abstract class TgInterface {
  FutureOr<void> close();
  FutureOr<void> login(LoginParams loginParams);
  FutureOr<void> saveChatsHistory(DateTime dateTimeFrom);
}

class LoginParams {
  final int apiId;
  final String apiHash;
  final String phoneNumber;
  final String databasePath;
  final String Function() readTelegramCode;
  final void Function(String) writeQrCodeLink;
  final String Function() readUserFirstName;
  final String Function() readUserLastName;
  final String Function() readUserPassword;

  LoginParams(
    this.apiId,
    this.apiHash,
    this.phoneNumber,
    this.databasePath,
    this.readTelegramCode,
    this.writeQrCodeLink,
    this.readUserFirstName,
    this.readUserLastName,
    this.readUserPassword,
  );
}

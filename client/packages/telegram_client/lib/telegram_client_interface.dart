import 'dart:async';

import 'package:td_json_client/td_api.dart';

import 'db_isolated.dart';
import 'ingester_contract.dart';

abstract class TelegramClientInterface {
  FutureOr<void> close();
  FutureOr<void> login(LoginParams loginParams);
  FutureOr<void> logout();
  FutureOr<Message> readChatMessage(String chatName, int messageId);
  FutureOr<void> saveChatsHistory(DateTime dateTimeFrom,
      IngesterContractParams ingesterContractParams, DbIsolated db);
  StreamController<dynamic> subscribe();
  Future<dynamic> callTdFunction(TdFunction tdFunction);
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

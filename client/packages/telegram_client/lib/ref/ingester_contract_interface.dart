import 'dart:async';

abstract class IngesterContractInterface {
  Future<List<String>> getChatsNames();
}

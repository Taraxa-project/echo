import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi_ext;
import 'dart:convert' as convert;
import 'package:loggy/loggy.dart';

import 'package:telegram_client/src/lib_td_json.dart';

mixin TelegramClientLoggy implements LoggyType {
  @override
  Loggy<TelegramClientLoggy> get loggy =>
      Loggy<TelegramClientLoggy>('Telegram Client - $runtimeType');
}

class TelegramClient with TelegramClientLoggy {
  final String libtdjsonPath;
  final int libtdjsonLoglevel;

  final int apiId;
  final String apiHash;
  final String phoneNumber;

  late final LibTdJson _libTdJson;
  late final int _tdClientId;

  bool _isAuthorized = false;
  bool _isClosed = false;

  bool get isAuthorized => _isAuthorized;
  bool get isClosed => _isClosed;

  TelegramClient(
      {required String this.libtdjsonPath,
      required int this.apiId,
      required String this.apiHash,
      required String this.phoneNumber,
      int this.libtdjsonLoglevel = 1}) {
    loggy.debug('Loading libdtjson from $libtdjsonPath...');
    _libTdJson = LibTdJson(ffi.DynamicLibrary.open(libtdjsonPath));
    loggy.debug('Loaded libdtjson.');

    loggy.debug('Creating libdtjson client id...');
    _tdClientId = _libTdJson.td_create_client_id();
    loggy.debug('Created libtdjson client id $_tdClientId');

    loggy.debug('Setting libtdjson log level to $libtdjsonLoglevel...');
    execute({
      '@type': 'setLogVerbosityLevel',
      'new_verbosity_level': libtdjsonLoglevel
    });
  }

  Future<void> signUp(String Function() readTelegramCode) async {
    await send({'@type': 'getAuthorizationState'});

    await for (var response in receive()
        .where((event) => event['@type'] == 'updateAuthorizationState')) {
      switch (response['authorization_state']['@type']) {
        case 'authorizationStateClosed':
          loggy.warning('Authorization state closed.');
          _isClosed = true;
          break;
        case 'authorizationStateReady':
          _isAuthorized = true;
          loggy.info('Logged in successfuly');
          break;
        case 'authorizationStateWaitTdlibParameters':
          send({
            '@type': 'setTdlibParameters',
            'parameters': {
              'api_id': apiId,
              'api_hash': apiHash,
              'system_language_code': 'en',
              'database_directory': 'tdlib',
              'use_message_database': false,
              'device_model': 'Desktop',
              'application_version': '1.0',
            }
          });
          break;
        case 'authorizationStateWaitEncryptionKey':
          send({
            '@type': 'checkDatabaseEncryptionKey',
            'encryption_key': '',
          });
          break;
        case 'authorizationStateWaitPhoneNumber':
          send({
            '@type': 'setAuthenticationPhoneNumber',
            'phone_number': phoneNumber,
          });
          break;
        case 'authorizationStateWaitCode':
          send({
            '@type': 'checkAuthenticationCode',
            'code': readTelegramCode(),
          });
          break;
      }

      if (_isClosed || _isAuthorized) {
        break;
      }
    }
  }

  Stream<dynamic> getChats() async* {
    send({
      '@type': 'loadChats',
      'limit': 1000,
    });
    await for (var response in receive(doBreak: true)) {
      switch (response['@type']) {
        case 'updateNewChat':
          yield {
            'id': response['chat']['id'],
            'name': response['chat']['title'],
            'type': response['chat']['@type'],
          };
          break;
        case 'updateSupergroup':
          yield {
            'id': response['supergroup']['id'],
            'name': response['supergroup']['username'],
            'type': response['supergroup']['@type'],
          };
          break;
        case 'updateBasicGroup':
          yield {
            'id': response['basic_group']['id'],
            // 'name': response['basicGroup']['username'] ?? '',
            'type': response['basic_group']['@type'],
          };
          break;
      }
    }
  }

  void execute(dynamic request) {
    String requestJson = convert.jsonEncode(request);
    loggy.info('Executing $requestJson...');
    _libTdJson.td_execute(requestJson.toNativeUtf8().cast<ffi.Char>());
  }

  Future<void> send(dynamic request) async {
    String requestJson = convert.jsonEncode(request);
    loggy.info('Sending $requestJson from client id $_tdClientId...');
    _libTdJson.td_send(_tdClientId,
        convert.jsonEncode(request).toNativeUtf8().cast<ffi.Char>());
  }

  Stream<dynamic> receive(
      {double waitTimeout = 5.0, bool doBreak = false}) async* {
    while (true) {
      final ffi.Pointer<ffi.Int> tdResponse =
          _libTdJson.td_receive(waitTimeout);
      if (tdResponse == ffi.nullptr) {
        if (doBreak) {
          break;
        } else {
          continue;
        }
      }

      final String responseJson =
          tdResponse.cast<ffi_ext.Utf8>().toDartString();
      loggy.info('Received $responseJson to client id $_tdClientId.');

      final response = convert.jsonDecode(responseJson);
      if (response != null) {
        yield response;
      }
    }
  }
}

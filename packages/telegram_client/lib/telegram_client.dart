import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi_ext;
import 'dart:convert' as convert;
import 'package:loggy/loggy.dart';

import 'package:telegram_client/src/lib_td_json.dart';
import 'package:telegram_client/td_api.dart';

mixin TelegramClientLoggy implements LoggyType {
  @override
  Loggy<TelegramClientLoggy> get loggy =>
      Loggy<TelegramClientLoggy>('$runtimeType');
}

class TelegramClient with TelegramClientLoggy {
  final String libtdjsonPath;
  final int libtdjsonLoglevel;

  final int apiId;
  final String apiHash;
  final String phoneNumber;
  final String databasePath;

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
      required String this.databasePath,
      int this.libtdjsonLoglevel = 1,
      logLevelName = 'Error'}) {
    initLogger(logLevelName);

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
    await send(GetAuthorizationState());

    await for (var response
        in receive().where((event) => event is UpdateAuthorizationState)) {
      var updateAuthorizationState = response as UpdateAuthorizationState;
      switch (updateAuthorizationState.authorization_state.runtimeType) {
        case AuthorizationStateClosed:
          loggy.warning('Authorization state closed.');
          _isClosed = true;
          break;

        case AuthorizationStateReady:
          _isAuthorized = true;
          loggy.info('Logged in successfuly');
          break;

        case AuthorizationStateWaitTdlibParameters:
          send(SetTdlibParameters(
              parameters: TdlibParameters(
            api_id: apiId,
            api_hash: apiHash,
            system_language_code: 'en',
            database_directory: databasePath,
            use_message_database: false,
            device_model: 'Desktop',
            application_version: '1.0',
          )));
          break;

        case AuthorizationStateWaitEncryptionKey:
          send(CheckDatabaseEncryptionKey(encryption_key: ''));
          break;

        case AuthorizationStateWaitPhoneNumber:
          send(SetAuthenticationPhoneNumber(phone_number: phoneNumber));
          break;

        case AuthorizationStateWaitCode:
          send(CheckAuthenticationCode(code: readTelegramCode()));

          break;
      }

      if (_isClosed || _isAuthorized) {
        break;
      }
    }
  }

  Stream<dynamic> getChats() async* {
    send(GetChats(limit: 1000));

    await for (var response in receive().where((event) =>
        event is UpdateSupergroupFullInfo ||
        event is UpdateBasicGroupFullInfo ||
        event is UpdateUserFullInfo)) {
      yield response;
    }
  }

  void execute(dynamic request) {
    String requestJson = convert.jsonEncode(request);
    loggy.info('Executing $requestJson...');
    _libTdJson.td_execute(requestJson.toNativeUtf8().cast<ffi.Char>());
  }

  Future<void> send(TdFunction request) async {
    String requestJson = request.toJson();
    loggy.info('Sending $requestJson from client id $_tdClientId...');
    _libTdJson.td_send(
        _tdClientId, requestJson.toNativeUtf8().cast<ffi.Char>());
  }

  Stream<dynamic> receive({double waitTimeout = 5.0}) async* {
    while (true) {
      final ffi.Pointer<ffi.Int> tdResponse =
          _libTdJson.td_receive(waitTimeout);
      if (tdResponse == ffi.nullptr) {
        continue;
      }

      final String responseJson =
          tdResponse.cast<ffi_ext.Utf8>().toDartString();
      loggy.info('Received $responseJson to client id $_tdClientId.');

      final response = convert.jsonDecode(responseJson);
      if (response != null) {
        var tlObject = TlMap.fromMap(response);
        if (tlObject == null) {
          loggy.error('Could not find td mapping for: $responseJson.');
        } else {
          yield tlObject;
        }
      }
    }
  }

  void initLogger(String logLevelName) {
    var logLevel = LogLevel.values.firstWhere(
        (element) => element.name == logLevelName,
        orElse: () => LogLevel.all);
    var logOptions = LogOptions(logLevel);

    Loggy.initLoggy(
        logPrinter: const PrettyPrinter(),
        logOptions: logOptions,
        hierarchicalLogging: true);

    loggy.level = logOptions;
  }
}

import 'dart:io';
import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import 'package:echo_cli/callback/cli.dart';
import 'package:telegram_client/log_isolated.dart';
import 'package:telegram_client/telegram_client_interface.dart';
import 'package:telegram_client/telegram_client_isolated.dart';

class TelegramGetMessageCommand extends Command {
  final name = 'message';
  final description = 'Read chat message.';

  void run() async {
    _readChatMessage();
  }

  Future<void> _readChatMessage() async {
    hierarchicalLoggingEnabled = true;

    LogIsolated? log;
    TelegramClientIsolated? telegramClient;

    final subscriptionSignalHandler = _initSignalHandler(log, telegramClient);

    final logLevel = _parseLogLevel();
    final logLevelLibTdJson = _parseLogLevelLibtdjson();
    final fileNameLibTdJson = globalResults!['libtdjson-path'];
    final proxyUri = _parseProxyUri();
    final loginParams = _buildLoginParams();

    final chatName = globalResults!.command!['chat-name'];
    final messageId = _parseInt(
        globalResults!.command!['message-id'], 'message-id is not int');

    try {
      log = await LogIsolated.spawn(logLevel);
      telegramClient = await TelegramClientIsolated.spawn(
          log, fileNameLibTdJson, logLevelLibTdJson, proxyUri);

      await telegramClient.login(loginParams);
      final message = await telegramClient.readChatMessage(chatName, messageId);

      print(message);
    } on Object {
      rethrow;
    } finally {
      subscriptionSignalHandler.cancel();
      _exitIsolates(log, telegramClient);
    }
  }

  StreamSubscription _initSignalHandler(
      LogIsolated? log, TelegramClientIsolated? telegramClient) {
    return ProcessSignal.sigint.watch().listen((signal) async {
      if ((signal == ProcessSignal.sigint) |
          (signal == ProcessSignal.sigkill)) {
        await _exitIsolates(log, telegramClient);
        exit(0);
      }
    });
  }

  Future<void> _exitIsolates(
      LogIsolated? log, TelegramClientIsolated? telegramClient) async {
    await telegramClient?.close();
    log?.exit();
  }

  LoginParams _buildLoginParams() {
    return LoginParams(
      _parseInt(globalResults!['api-id'], '--api-id must be an integer'),
      globalResults!['api-hash'],
      globalResults!['phone-number'],
      globalResults!['database-path'],
      readTelegramCode,
      writeQrCodeLink,
      readUserFirstName,
      readUserLastName,
      readUserPassword,
    );
  }

  Level _parseLogLevel() {
    return _parseLogLevelByName(globalResults!['loglevel']);
  }

  Level _parseLogLevelLibtdjson() {
    return _parseLogLevelByName(globalResults!['libtdjson-loglevel']);
  }

  Level _parseLogLevelByName(String name) {
    return Level.LEVELS.firstWhere(
      (level) => level.name == name.toUpperCase(),
      orElse: () => throw Exception('Invalid log level $name'),
    );
  }

  int _parseInt(String intToParse, String message) {
    try {
      return int.parse(intToParse);
    } on FormatException {
      throw Exception(message);
    }
  }

  Uri? _parseProxyUri() {
    Uri? uri;

    if (globalResults?['proxy'] != null) {
      try {
        uri = Uri.parse(globalResults?['proxy']);
        if (['http', 'socks5'].contains(uri.scheme)) {
          return uri;
        } else {
          throw Exception('Invalid proxy scheme ${uri.scheme}.'
              ' Allowed values: http, socks5.');
        }
      } on FormatException catch (ex) {
        throw Exception('Invalid proxy URI: $ex');
      }
    }

    return uri;
  }
}

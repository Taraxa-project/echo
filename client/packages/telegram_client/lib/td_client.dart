import 'dart:async';

import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';
import 'package:td_json_client/td_api.dart';
import 'package:td_json_client/td_json_client.dart';

class TdClient {
  final Logger logger;

  late final TdJsonClient _tdJsonClient;
  late final int _tdJsonClientId;

  Timer? _tdReceiveTimer;
  bool _isTdReceiving = false;
  Duration tdReceiveFrequency = Duration(milliseconds: 10);
  double tdReceiveWaitTimeout = 0.005;

  late final StreamController tdEvents;

  static const int tgRetryCountMax = 5;
  static const int tgTimeoutMilliseconds = 15 * 1000;
  static const int tgTimeoutDelayMilliseconds = 50;
  static const int delayTimeoutSeconds = 15;

  static const int delayParseErrorSeconds = 60 * 60 * 24;
  static const int delayFloodWaitMultiplier = 2;

  TdClient(
    this.logger,
    String libtdjsonlcPath,
    Level logLevelLibTdJson,
    Uri? proxyUri,
  ) {
    _initTdLib(libtdjsonlcPath, logLevelLibTdJson);
    _initReceiver();
    _initProxy(proxyUri);
  }

  Future<void> close() async {
    logger.info('closing...');
    _tdJsonClient.exit();
    await tdEvents.close();
  }

  Future<TdObject> retryTdCall(TdFunction tdFunction) async {
    var retryCountIndex = 0;
    while (retryCountIndex < tgRetryCountMax) {
      retryCountIndex += 1;
      try {
        return await tdCall(tdFunction);
      } on TgFloodWaiException catch (ex) {
        logger.warning('received flood wait for '
            '${tdFunction.runtimeType.toString()}. '
            'Retrying in ${ex.waitSeconds} seconds.');
        await Future.delayed(Duration(seconds: ex.waitSeconds));
      } on TgTimeOutException {
        logger.warning('time out for '
            '${tdFunction.runtimeType.toString()}. '
            'Retrying in ${delayTimeoutSeconds} seconds.');
        await Future.delayed(Duration(seconds: delayTimeoutSeconds));
      }
    }
    throw TgMaxRetriesExcedeedException(tgRetryCountMax);
  }

  Future<TdObject> tdCall(TdFunction tdFunction) async {
    final extra = Uuid().v1();

    var tdResponse;
    final sub = tdEvents.stream.where((event) {
      return event.extra == extra;
    }).listen((event) {
      tdResponse = event;
    });

    tdFunction.extra = extra;
    tdSend(tdFunction);

    int elapsedMilliseconds = 0;
    while (elapsedMilliseconds <= tgTimeoutMilliseconds) {
      if (tdResponse != null) {
        break;
      }
      elapsedMilliseconds += tgTimeoutDelayMilliseconds;
      await Future.delayed(Duration(milliseconds: tgTimeoutDelayMilliseconds));
    }

    sub.cancel();

    if (tdResponse == null) {
      throw TgTimeOutException(
        elapsedMilliseconds,
        tdFunction.runtimeType.toString(),
      );
    } else if (tdResponse is Error) {
      _handleTdError(tdResponse);
    } else {
      return tdResponse;
    }
  }

  void tdSend(TdFunction tdFunction) {
    logger.finer('sending $tdFunction...');
    _tdJsonClient.send(_tdJsonClientId, tdFunction);
  }

  void _initTdLib(String libtdjsonlcPath, Level logLevelLibTdJson) {
    logger.fine('init TdJsonClient...');

    _tdJsonClient = TdJsonClient(libtdjsonlcPath: libtdjsonlcPath);
    _tdJsonClientId = _tdJsonClient.create_client_id();
    logger.fine('client id is $_tdJsonClientId.');

    final loggerTdJsonClient = Logger('TdJsonClient')
      ..level = logger.level
      ..onRecord.listen((event) {
        logger.log(event.level, event.object);
      });
    _tdJsonClient.logger = loggerTdJsonClient;

    final loggerLibTdJson = Logger('LibTdJson')
      ..level = logLevelLibTdJson
      ..onRecord.listen((event) {
        logger.log(event.level, event.object);
      });
    _tdJsonClient.loggerTdLib = loggerLibTdJson;
  }

  void _initProxy(Uri? proxyUri) {
    logger.info('checking proxy...');

    if (proxyUri == null) {
      logger.info('not using proxy.');
      return;
    }

    String? username;
    String? password;

    if (proxyUri.userInfo.isNotEmpty) {
      RegExp exp = RegExp(r'(\w+)');
      Iterable<RegExpMatch> matches = exp.allMatches(proxyUri.userInfo);
      if (matches.length == 2) {
        username = matches.elementAt(0)[0];
        password = matches.elementAt(1)[0];
      }
    }

    final ProxyType proxyType;

    if (proxyUri.scheme == 'http') {
      proxyType = ProxyTypeHttp(
        username: username,
        password: password,
      );
    } else if (proxyUri.scheme == 'socks5') {
      proxyType = ProxyTypeSocks5(
        username: username,
        password: password,
      );
    } else {
      logger.warning('invalid proxy scheme ${proxyUri.scheme}.');
      logger.info('not using proxy.');
      return;
    }

    logger.info('adding proxy...');

    _tdJsonClient.send(
        _tdJsonClientId,
        AddProxy(
          server: proxyUri.host,
          port: proxyUri.port,
          type: proxyType,
          enable: true,
        ));
  }

  void _initReceiver() {
    tdEvents = StreamController.broadcast(
      onListen: _tdStart,
      onCancel: _tdStop,
    );
  }

  void _tdStart() {
    logger.finer('starting the receive timer...');
    _tdReceiveTimer = Timer.periodic(tdReceiveFrequency, _tdReceive);
    logger.finer('receive timer started.');
  }

  void _tdStop() {
    logger.finer('stopping the receive timer...');
    _tdReceiveTimer?.cancel();
    _tdReceiveTimer = null;
    logger.finer('receive timer stopped.');
  }

  void _tdReceive(Timer timer) {
    if (!_isTdReceiving) {
      _isTdReceiving = true;

      final event = _tdJsonClient.receive(waitTimeout: tdReceiveWaitTimeout);
      if (event != null) {
        logger.finer('received ${event.runtimeType}.');
        if (event is UpdateConnectionState) {
          logger.info('connection state is ${event.state?.runtimeType}.');
        }
        tdEvents.add(event);
      }

      _isTdReceiving = false;
    }
  }

  int? _parseFloodWaitSeconds(String? message) {
    return _parseSeconds(message, 'FLOOD_WAIT_');
  }

  int? _parseTooManyRequestsSeconds(String? message) {
    return _parseSeconds(message, 'Too Many Requests: retry after ');
  }

  int? _parseSeconds(String? message, String replace) {
    return int.tryParse(message?.replaceFirst(replace, '') ?? '');
  }

  Never _handleTdError(Error error) {
    // TODO handle
    // 401 UNAUTHORIZED
    // 403 FORBIDDEN
    // 404 NOT_FOUND
    // 500 INTERNAL
    if (error.code == 400) {
      throw TgBadRequestException(
        error.message,
        error.code,
      );
    } else if (error.code == 420) {
      final floodWaitSeconds = _parseFloodWaitSeconds(error.message);
      if (floodWaitSeconds == null) {
        logger.warning('could not parse flood wait seconds: '
            '${error.message}. '
            'Using default: $delayParseErrorSeconds seconds.');
        throw TgFloodWaiException(delayParseErrorSeconds);
      } else {
        throw TgFloodWaiException(floodWaitSeconds * delayFloodWaitMultiplier);
      }
    } else if (error.code == 429) {
      final floodWaitSeconds = _parseTooManyRequestsSeconds(error.message);
      if (floodWaitSeconds == null) {
        logger.warning('could not parse too many requests wait seconds: '
            '${error.message}. '
            'Using default: $delayParseErrorSeconds seconds.');
        throw TgFloodWaiException(delayParseErrorSeconds);
      } else {
        throw TgFloodWaiException(floodWaitSeconds * delayFloodWaitMultiplier);
      }
    } else if (error.code == 404) {
      throw TgNotFoundException(
        error.message,
        error.code,
      );
    } else if (error.code == 406) {
      throw TgNotExceptableException(
        'Handle me: '
        'https://core.telegram.org/api/errors#406-not-acceptable',
        error.code,
      );
    } else {
      throw TgErrorCodeNotHandledException(
        error.message,
        error.code,
      );
    }
  }
}

class TgException implements Exception {
  final String? message;

  TgException([this.message = '']);

  String toString() {
    var report = 'TgException';
    if (message != null) {
      report += ': $message';
    }
    return report;
  }
}

class TgChatNotFoundException implements Exception {
  final String? message;

  TgChatNotFoundException([
    this.message = '',
  ]);

  String toString() {
    var report = 'TgChatNotFoundException';
    if (message != null) {
      report += ': $message';
    }
    return report;
  }
}

class TgBadRequestException implements Exception {
  final String? message;
  final int? code;

  TgBadRequestException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = runtimeType.toString();
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgNotFoundException implements Exception {
  final String? message;
  final int? code;

  TgNotFoundException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = runtimeType.toString();
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgNotExceptableException implements Exception {
  final String? message;
  final int? code;

  TgNotExceptableException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = runtimeType.toString();
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgErrorCodeNotHandledException implements Exception {
  final String? message;
  final int? code;

  TgErrorCodeNotHandledException([
    this.message = '',
    this.code = 0,
  ]);

  String toString() {
    var report = runtimeType.toString();
    if (message != null) {
      report += ': $message';
    }
    if (code != null) {
      report += ', code: $code';
    }
    return report;
  }
}

class TgFloodWaiException implements Exception {
  final int waitSeconds;

  TgFloodWaiException(
    this.waitSeconds,
  );

  String toString() {
    return '${runtimeType.toString()}: $waitSeconds';
  }
}

class TgMaxRetriesExcedeedException implements Exception {
  final int maxRetries;

  TgMaxRetriesExcedeedException(
    this.maxRetries,
  );

  String toString() {
    return '${runtimeType.toString()}: $maxRetries';
  }
}

class TgTimeOutException implements Exception {
  final int millisenconds;
  final String request;

  TgTimeOutException(
    this.millisenconds,
    this.request,
  );

  String toString() {
    return '${runtimeType.toString()}'
        'request $request timed out '
        'after ${millisenconds / 1000} seconds.';
  }
}

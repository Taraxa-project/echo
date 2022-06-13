library telegram_client;

import 'dart:async';
import 'dart:io';
import 'dart:ffi' as ffi;
import 'dart:math';
import 'dart:isolate';
import 'dart:convert' as convert;

import 'package:ffi/ffi.dart' as pkgffi;
import 'package:http/http.dart';
import 'package:hexaminate/hexaminate.dart';

part 'src/request.dart';
part 'src/telegram.dart';
part 'tdlib/tdlib.dart';

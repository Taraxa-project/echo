#!/bin/bash
cd dart_api/sl/packages
dart pub global activate melos
melos bootstrap
melos run get
dart run ./sl_cli/main.dart

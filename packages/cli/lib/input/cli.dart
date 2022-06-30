import 'dart:io';

String readTelegramCode() {
  final RegExp fiveDigitsRegExp = RegExp(r"^\d{5}$");
  while (true) {
    print('Enter Telegram code:');
    String inputLine = stdin.readLineSync() ?? '';
    if (fiveDigitsRegExp.hasMatch(inputLine)) {
      return inputLine;
    }
    print('Telegram code must be a five digits number.');
  }
}

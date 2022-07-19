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

void writeQrCodeLink(String? link) {
  print('Confirm authorization on another logged in device '
      'by scanning a QR code provided by this link: $link.');
}

String readUserFirstName() {
  while (true) {
    print('Enter your first name:');
    String? inputLine = stdin.readLineSync();
    if (inputLine != null) {
      return inputLine;
    }
  }
}

String readUserLastName() {
  while (true) {
    print('Enter your last name:');
    String? inputLine = stdin.readLineSync();
    if (inputLine != null) {
      return inputLine;
    }
  }
}

String readUserPassword() {
  stdin.echoMode = false;
  while (true) {
    print('Enter your password:');
    String? inputLine = stdin.readLineSync();
    if (inputLine != null) {
      stdin.echoMode = true;
      return inputLine;
    }
  }
}

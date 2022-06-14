import 'package:args/command_runner.dart';

class CommandSignup extends Command {
  final name = 'signup';
  final description = 'Sign up a Telegram account.';

  void run() {
    var phoneNumber = globalResults!['phone-number'];
    print(phoneNumber);
  }
}

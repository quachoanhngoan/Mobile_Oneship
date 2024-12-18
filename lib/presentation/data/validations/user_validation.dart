import 'package:oneship_merchant_app/core/core.dart';

class UserValidate {
  bool emailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  String? passValid(String password) {
    if (password.length < 8 || password.length > 16) {
      return AppErrorString.kPasswordTooShort;
    } else {
      RegExp reglowUpper = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])');
      if (!reglowUpper.hasMatch(password)) {
        return AppErrorString.kPasswordUpper;
      } else {
        RegExp symbol = RegExp(r'^(?=.*?[%@#$])');
        if (!symbol.hasMatch(password)) {
          return AppErrorString.kPasswordSymbol;
        }
      }
    }
    return null;
  }

  bool phoneValid(String phone) {
    return RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(phone);
  }

  bool nameValid(String name) {
    if (name.length >= 3) {
      return !RegExp(r"\d").hasMatch(name);
    }
    return false;
  }

  bool addressValid(String address) {
    if (address.length >= 5) {
      return true;
    }
    return false;
  }
}

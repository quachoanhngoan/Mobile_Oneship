class ValidateHelper {
  static bool validatePhone(String phone) {
    if (phone.isEmpty) {
      return false;
    }
    if (phone.length < 10) {
      return false;
    }
    if (phone.length > 10) {
      return false;
    }
    final bool phoneValid =
        RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone);

    return phoneValid;
  }

  static bool validatePassword(String password) {
    if (password.isEmpty) {
      return false;
    }
    if (password.length < 6) {
      return false;
    }
    return true;
  }
}

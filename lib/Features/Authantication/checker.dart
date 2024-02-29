class Checker {
  Checker._();

  static bool checkName(String name) {
    final nameValid = RegExp(r'^[a-zA-Z ]+$');
    return nameValid.hasMatch(name);
  }

  static bool checkEmail(String email) {
    final emailValid = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailValid.hasMatch(email);
  }

  static bool checkPassword(String password) {
    final passwordValid =
 RegExp(r'[a-z0-9]{9,}$/');
    return passwordValid.hasMatch(password);
  }
}
abstract class EmailValidator {
  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{1,}))$')
        .hasMatch(email);
  }
}

class FieldValidators {
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 4) {
      return "Please enter minimum 4 character password";
    } else if (value.length >= 40) {
      return "Please enter password less than 40 character";
    }
  }

  String? validateTwit(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return "Please type your twit";
    } else if (value.length > 280) {
      return "Max twit size is 280 character";
    }
  }

  String? validateEmail(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    } else if (!EmailValidator.isValidEmail(value)) {
      return "Please enter a valid email";
    }
  }
}

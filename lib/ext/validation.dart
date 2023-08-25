import 'package:email_validator/email_validator.dart';

extension AccountValidation on String {
  String get validateAccount {
    if (isEmpty) {
      return "Please enter your account";
    } else if (isNumeric) {
      return isPhoneValid;
    } else {
      return EmailValidator.validate(this)
          ? ""
          : "Please Enter a Valid Email Address";
    }
  }

  String get isPhoneValid {
    var phoneRegex = RegExp(
        r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
    if (isEmpty) {
      return "Please enter a phone number";
    } else if (!phoneRegex.hasMatch(this)) {
      return "Please Enter a Valid Phone Number";
    } else {
      return "";
    }
  }

  String get isPasswordValid {
    if (isEmpty) {
      return "Please enter your password";
    } else if (length < 8) {
      return "Your password must have at least 8 character";
    } else {
      return "";
    }
  }

  String isPasswordConfirmed(String password) {
    if (isEmpty) {
      return "Please confirm your password";
    } else if (this != password) {
      return "Confirmed password is not match!";
    } else {
      return "";
    }
  }

  bool get isNumeric => int.tryParse(this) != null ? true : false;
}

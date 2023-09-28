extension StringValidatorExt on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

  bool get hasUpperCase {
    final pattern = RegExp(r'[A-Z]');
    return pattern.hasMatch(this);
  }

  bool get hasSpecialCharacter {
    final pattern = RegExp(r'[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]');
    return pattern.hasMatch(this);
  }

  bool get hasNumber {
    final pattern = RegExp(r'[0-9]');
    return pattern.hasMatch(this);
  }

  bool get hasLowerCase {
    final pattern = RegExp(r'[a-z]');
    return pattern.hasMatch(this);
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please Enter Your Password';
  } else if (value.length < 8) {
    return 'Password must contains more than 8 characters';
  } else if (!value.hasUpperCase) {
    return 'Password does not contain an uppercase letter.';
  } else if (!value.hasSpecialCharacter) {
    return 'Password must contain at least one special character.';
  } else if (!value.hasNumber) {
    return 'Password must contains at least one number';
  } else if (!value.hasLowerCase) {
    return 'Password does not contain any lowercase alphabet.';
  } else if (!value.isValidPassword) {
    return 'Please Enter Valid Password';
  }
  return null;
}

String? validateEmailOrPhone(String value) {
  if (value.isValidEmail || value.isValidPhone) {
    return null;
  } else {
    return 'Please enter a valid email or phone number';
  }
}

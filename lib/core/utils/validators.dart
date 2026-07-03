class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email required';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 8) {
      return 'Minimum 8 characters';
    }

    return null;
  }
}

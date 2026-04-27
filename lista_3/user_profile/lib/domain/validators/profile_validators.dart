class ProfileValidators {
  static String? validateName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Please enter your name.';
    }
    if (text.length < 2) {
      return 'Name must contain at least 2 characters.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Please enter your email.';
    }

    const emailPattern = r'^[\w\.-]+@[\w\.-]+\.[A-Za-z]{2,}$';
    final emailRegex = RegExp(emailPattern);
    if (!emailRegex.hasMatch(text)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }
}

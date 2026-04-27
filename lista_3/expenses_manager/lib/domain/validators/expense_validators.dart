class ExpenseValidators {
  static String? validateDescription(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Please enter a description.';
    }
    if (text.length < 5) {
      return 'Description must contain at least 5 characters.';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Please enter an amount.';
    }

    try {
      final amount = double.parse(text);
      if (amount <= 0) {
        return 'Amount must be greater than zero.';
      }
      return null;
    } catch (e) {
      return 'Please enter a valid amount.';
    }
  }
}

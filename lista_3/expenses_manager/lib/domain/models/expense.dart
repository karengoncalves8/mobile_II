class Expense {
  const Expense({
    required this.value,
    required this.description,
  });

  final double value;
  final String description;

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'description': description,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    final rawValue = json['value'];
    return Expense(
      value: rawValue is num ? rawValue.toDouble() : 0.0,
      description: (json['description'] as String? ?? '').trim(),
    );
  }
}

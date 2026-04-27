class Product {
  const Product({
    required this.id,
    required this.name,
    required this.amount,
  });

  final int id;
  final String name;
  final int amount;

  Product copyWith({int? id, String? name, int? amount}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }
}

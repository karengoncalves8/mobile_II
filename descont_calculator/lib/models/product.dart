class Product {
  final DateTime prodId;
  final String? name;
  final double? price;
  final double? discount;

  Product({required this.prodId, this.name, this.price, this.discount});

  double get discountedPrice => price != null && discount != null ? price! - (price! * discount! / 100) : 0;
}

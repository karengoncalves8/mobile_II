import 'package:products_catalog/enums/category.dart';

class Product {
  final String name;
  final double price;
  final Category category;

  Product({
    required this.name,
    required this.price,
    required this.category,
  });
}
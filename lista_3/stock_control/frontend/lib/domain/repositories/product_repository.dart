import 'package:frontend/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> listProducts();
  Future<Product> createProduct({required String name, required int amount});
  Future<Product> updateProduct({
    required int id,
    required String name,
    required int amount,
  });
  Future<void> deleteProduct(int id);
}

import 'package:flutter/foundation.dart';
import 'package:frontend/domain/entities/product.dart';
import 'package:frontend/domain/repositories/product_repository.dart';

class StockController extends ChangeNotifier {
  StockController({required this.repository});

  final ProductRepository repository;

  List<Product> _products = <Product>[];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get totalItems => _products.fold<int>(0, (int sum, Product p) => sum + p.amount);

  Future<void> loadProducts() async {
    _setLoading(true);
    _setError(null);

    try {
      _products = await repository.listProducts();
    } catch (error) {
      _setError(error.toString().replaceFirst('Exception: ', ''));
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addProduct({required String name, required int amount}) async {
    _setError(null);

    try {
      await repository.createProduct(name: name.trim(), amount: amount);
      _products = await repository.listProducts();
      notifyListeners();
      return true;
    } catch (error) {
      _setError(error.toString().replaceFirst('Exception: ', ''));
      notifyListeners();
      return false;
    }
  }

  Future<bool> saveProduct({
    required int id,
    required String name,
    required int amount,
  }) async {
    _setError(null);

    try {
      await repository.updateProduct(id: id, name: name.trim(), amount: amount);
      _products = await repository.listProducts();
      notifyListeners();
      return true;
    } catch (error) {
      _setError(error.toString().replaceFirst('Exception: ', ''));
      notifyListeners();
      return false;
    }
  }

  Future<void> removeProduct(int id) async {
    _setError(null);

    final previous = _products;
    _products = _products.where((Product product) => product.id != id).toList(growable: false);
    notifyListeners();

    try {
      await repository.deleteProduct(id);
    } catch (error) {
      _products = previous;
      _setError(error.toString().replaceFirst('Exception: ', ''));
      notifyListeners();
    }
  }

  void clearError() {
    _setError(null);
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _errorMessage = value;
  }
}

import 'dart:convert';

import 'package:frontend/domain/entities/product.dart';
import 'package:frontend/domain/repositories/product_repository.dart';
import 'package:frontend/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class HttpProductRepository implements ProductRepository {
  HttpProductRepository({required this.baseUrl, http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  @override
  Future<List<Product>> listProducts() async {
    final response = await httpClient.get(Uri.parse('$baseUrl/products'));
    _throwIfFailed(response);

    final body = jsonDecode(response.body) as List<dynamic>;
    return body
        .map((dynamic item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<Product> createProduct({
    required String name,
    required int amount,
  }) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/products'),
      headers: const <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{'name': name, 'amount': amount}),
    );

    _throwIfFailed(response);
    return ProductModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  @override
  Future<Product> updateProduct({
    required int id,
    required String name,
    required int amount,
  }) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: const <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{'name': name, 'amount': amount}),
    );

    _throwIfFailed(response);
    return ProductModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  @override
  Future<void> deleteProduct(int id) async {
    final response = await httpClient.delete(Uri.parse('$baseUrl/products/$id'));
    _throwIfFailed(response);
  }

  void _throwIfFailed(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    String message = 'Unexpected API error.';

    try {
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      final dynamic serverMessage = payload['message'];
      if (serverMessage is String && serverMessage.trim().isNotEmpty) {
        message = serverMessage;
      }
    } catch (_) {
      // Keep the fallback message when response body is not JSON.
    }

    throw Exception(message);
  }
}

import 'package:descont_calculator/models/product.dart';
import 'package:flutter/material.dart';

import 'package:descont_calculator/widgets/product_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Product> products = [];

  @override
  void initState() {
    super.initState();
    // Start with one empty product form so user can interact immediately.
    _addProduct();
  }

  void _addProduct() {
    final newProduct = Product(prodId: DateTime.now());
    setState(() {
      products.add(newProduct);
    });
  }

  void _updateProduct(int index, Product updatedProduct) {
    setState(() {
      products[index] = updatedProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Desconto')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addProduct,
                child: const Text('Adicionar Produto'),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductItemForm(
                    key: ValueKey(products[index].prodId),
                    product: products[index],
                    onProductChanged: (updatedProduct) {
                      _updateProduct(index, updatedProduct);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

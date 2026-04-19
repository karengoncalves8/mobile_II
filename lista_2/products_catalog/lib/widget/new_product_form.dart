import 'package:flutter/material.dart';
import 'package:products_catalog/enums/category.dart';
import 'package:products_catalog/models/Product.dart';



class NewProductForm extends StatefulWidget {
  final ValueChanged<Product> onProductAdded;

  const NewProductForm({required this.onProductAdded, super.key});

  @override
  State<NewProductForm> createState() => _NewProductFormState();
}

class _NewProductFormState extends State<NewProductForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _productNameController;
  late final TextEditingController _productPriceController;
  Category _selectedCategory = Category.eletronics;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController();
    _productPriceController = TextEditingController();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {

      final newProduct = Product(
        name: _productNameController.text.trim(),
        price: double.parse(_productPriceController.text.trim()),
        category: _selectedCategory,
      );
      widget.onProductAdded(newProduct);
      _productNameController.clear();
      _productPriceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _productNameController,
            decoration: const InputDecoration(
              labelText: 'Nome do Produto',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira o nome do produto';
              }
              return null;
            },
          ),

          TextFormField(
            controller: _productPriceController,
            decoration: const InputDecoration(
              labelText: 'Preço do Produto',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira o preço do produto';
              }
              return null;
            },
          ),
          Text('Categoria:'),
          RadioGroup(
            onChanged: (value) => setState(() => _selectedCategory = value!),
            groupValue: _selectedCategory,
            child: Column(
              children: [
                RadioListTile(
                  title: Text(Category.eletronics.name),
                  value: Category.eletronics,
                ),
                RadioListTile(
                  title: Text(Category.clothing.name),
                  value: Category.clothing,
                ),
                RadioListTile(
                  title: Text(Category.food.name),
                  value: Category.food,
                ),
                RadioListTile(
                  title: Text(Category.acessories.name),
                  value: Category.acessories,
                ),
                RadioListTile(
                  title: Text(Category.home.name),
                  value: Category.home,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Center(
            child: ElevatedButton(onPressed: _submit, child: const Text('Adicionar')),
          ),
        ],
      ),
    );
  }
}

import 'package:descont_calculator/models/product.dart';
import 'package:flutter/material.dart';

class ProductItemForm extends StatefulWidget {
  final Product product;
  final ValueChanged<Product> onProductChanged;

  const ProductItemForm({
    required this.product,
    required this.onProductChanged,
    super.key,
  });

  @override
  State<ProductItemForm> createState() => _ProductItemFormState();
}

class _ProductItemFormState extends State<ProductItemForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _discountController;

  String? _productName;
  double? _productPrice;
  double? _productDiscount;
  double? _discountedPrice;

  @override
  void initState() {
    super.initState();
    _productName = widget.product.name;
    _productPrice = widget.product.price;
    _productDiscount = widget.product.discount;
    _discountedPrice = (_productPrice != null && _productDiscount != null)
        ? _productPrice! - (_productPrice! * _productDiscount! / 100)
        : null;

    _nameController = TextEditingController(text: _productName ?? '');
    _priceController = TextEditingController(
      text: _productPrice?.toString() ?? '',
    );
    _discountController = TextEditingController(
      text: _productDiscount?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _productName = _nameController.text.trim();
      _productPrice = double.tryParse(_priceController.text);
      _productDiscount = double.tryParse(_discountController.text);

      if (_productPrice == null ||
          _productDiscount == null ||
          _productName == null) {
        // This should not happen due to validation, but just in case.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, insira valores válidos.')),
        );
        return;
      }

      setState(() {
        _discountedPrice =
            _productPrice! - (_productPrice! * _productDiscount! / 100);
      });

      widget.onProductChanged(
        Product(
          prodId: widget.product.prodId,
          name: _productName!,
          price: _productPrice!,
          discount: _productDiscount!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;

              final nameField = TextFormField(
                controller: _nameController,
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
              );

              final priceField = TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Preço do Produto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço do produto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              );

              final discountField = TextFormField(
                controller: _discountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Desconto do Produto (%)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o desconto do produto';
                  }
                  final parsedValue = double.tryParse(value);
                  if (parsedValue == null) {
                    return 'Por favor, insira um número válido';
                  }
                  if (parsedValue < 0 || parsedValue > 100) {
                    return 'O desconto deve estar entre 0 e 100';
                  }
                  return null;
                },
              );

              final actionButton = ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Calcular Desconto'),
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Expanded(flex: 3, child: nameField),
                        Expanded(flex: 2, child: priceField),
                        Expanded(flex: 2, child: discountField),
                        actionButton,
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 10,
                      children: [
                        nameField,
                        priceField,
                        discountField,
                        actionButton,
                      ],
                    ),
                  if (_discountedPrice != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Preço com Desconto: R\$ ${_discountedPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

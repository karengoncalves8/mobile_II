import 'package:flutter/material.dart';
import 'package:shopping_list/models/shopping_item.dart';

class NewItemForm extends StatefulWidget {
  final ValueChanged<ShoppingItem> onItemAdded;

  const NewItemForm({required this.onItemAdded, super.key});

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _itemController;

  @override
  void initState() {
    super.initState();
    _itemController = TextEditingController();
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newItem = ShoppingItem(name: _itemController.text.trim());
      widget.onItemAdded(newItem);
      _itemController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _itemController,
              decoration: const InputDecoration(
                labelText: 'Novo Item',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, insira um item';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shopping_list/models/shopping_item.dart';
import 'package:shopping_list/widgets/item_display.dart';
import 'package:shopping_list/widgets/new_item_form.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ShoppingItem> shoppingItems = [];

  void _addItem(ShoppingItem item) {
    setState(() {
      shoppingItems.add(item);
    });
  }

  void _onDeleteItem(ShoppingItem item) {
    setState(() {
      shoppingItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Compras')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          children: [
            NewItemForm(onItemAdded: _addItem),
            Expanded(
              child: ListView.builder(
                itemCount: shoppingItems.length,
                itemBuilder: (context, index) {
                  final item = shoppingItems[index];
                  return ItemDisplay(item: item, onDelete: () => _onDeleteItem(item));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

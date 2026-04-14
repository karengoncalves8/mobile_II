import 'package:flutter/material.dart';
import 'package:shopping_list/models/shopping_item.dart';

class ItemDisplay extends StatefulWidget {
  final ShoppingItem item;
  final VoidCallback onDelete;

  const ItemDisplay({required this.item, required this.onDelete, super.key});

  @override
  State<ItemDisplay> createState() => _ItemDisplayState();
}

class _ItemDisplayState extends State<ItemDisplay> {
  void _toggleBought() {
    setState(() {
      widget.item.toggleBought();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.item.name,
          style: TextStyle(
            decoration: widget.item.wasBought
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        leading: Checkbox(
          value: widget.item.wasBought,
          onChanged: (_) => _toggleBought(),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            widget.onDelete.call();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_list/models/task_item.dart';

class ItemDisplay extends StatefulWidget {
  final TaskItem item;

  const ItemDisplay({required this.item, super.key});

  @override
  State<ItemDisplay> createState() => _ItemDisplayState();
}

class _ItemDisplayState extends State<ItemDisplay> {
  void _toggleBought() {
    setState(() {
      widget.item.toggleDone();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.item.name,
          style: TextStyle(
            decoration: widget.item.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        leading: Checkbox(
          value: widget.item.isDone,
          onChanged: (_) => _toggleBought(),
        ),
        subtitle: widget.item.description.isNotEmpty ? Text(widget.item.description) : null,
        trailing: Badge(
          backgroundColor: widget.item.priority.color,
          label: Text(widget.item.priority.nome),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      ),
    );
  }
}

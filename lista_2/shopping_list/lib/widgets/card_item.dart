import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';

class CardItem extends StatefulWidget {
  final Item item;

  const CardItem({
    super.key,
    required this.item,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.item.name),
        trailing: Checkbox(
          value: widget.item.wasBought,
          onChanged: (value) {
            setState(() {
              widget.item.wasBought = value ?? false;
            });
          },
        ),
      ),
    );
  }
}
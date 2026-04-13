
import 'package:flutter/material.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/widgets/card_item.dart';
import 'package:shopping_list/widgets/new_item_form.dart';

class Home extends StatefulWidget {
    final List<Item> items;

    const Home({super.key, this.items = const []});

    @override
    State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    late final List<Item> _items;

    @override
    void initState() {
        super.initState();
        _items = List<Item>.from(widget.items);
    }

    void onSubmit(String name) {
        setState(() {
            _items.add(Item(name: name, wasBought: false));
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Lista de Compras'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    children: [
                        NewItemForm(onSubmit: onSubmit),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                                return CardItem(item: _items[index]);
                            },
                        ),                  
                    ],
                )
            ),
        );
    }
}

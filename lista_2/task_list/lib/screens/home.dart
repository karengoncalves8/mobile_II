import 'package:flutter/material.dart';
import 'package:task_list/models/task_item.dart';
import 'package:task_list/widgets/item_display.dart';
import 'package:task_list/widgets/new_item_form.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<TaskItem> tasks = [];

  void _addItem(TaskItem item) {
    setState(() {
      tasks.add(item);
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
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final item = tasks[index];
                  return ItemDisplay(item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

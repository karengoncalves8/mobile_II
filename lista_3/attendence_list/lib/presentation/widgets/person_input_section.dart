import 'package:flutter/material.dart';

class PersonInputSection extends StatelessWidget {
  const PersonInputSection({
    super.key,
    required this.controller,
    required this.onAdd,
    this.isBusy = false,
  });

  final TextEditingController controller;
  final Future<void> Function() onAdd;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Add Person', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => onAdd(),
              decoration: const InputDecoration(
                labelText: 'Person name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_add_alt_1),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: isBusy ? null : onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Add to list'),
            ),
          ],
        ),
      ),
    );
  }
}

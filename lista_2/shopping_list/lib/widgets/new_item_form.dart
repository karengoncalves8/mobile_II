import 'package:flutter/material.dart';

class NewItemForm extends StatefulWidget {
  final Function(String) onSubmit;

  const NewItemForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Novo item',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um item';
              }
              return null;
            },
          ),
        ),
        IconButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSubmit(_controller.text);
              _controller.clear();
            }
          },
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}
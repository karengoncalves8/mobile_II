import 'package:fast_notes/models/note.dart';
import 'package:flutter/material.dart';

class NewNoteForm extends StatefulWidget {
  final ValueChanged<Note> onItemAdded;

  const NewNoteForm({required this.onItemAdded, super.key});

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _noteTitleController;
  late final TextEditingController _noteContentController;

  @override
  void initState() {
    super.initState();
    _noteTitleController = TextEditingController();
    _noteContentController = TextEditingController();
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newItem = Note(
        title: _noteTitleController.text.trim(),
        content: _noteContentController.text.trim(),
      );
      widget.onItemAdded(newItem);
      _noteTitleController.clear();
      _noteContentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _noteTitleController,
            decoration: const InputDecoration(
              labelText: 'Título da Nota',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira o título da nota';
              }
              return null;
            },
          ),

          TextFormField(
            controller: _noteContentController,
            decoration: const InputDecoration(
              labelText: 'Conteúdo da Nota',
              border: OutlineInputBorder(),
            ),
            maxLines: 8,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira o conteúdo da nota';
              }
              return null;
            },
          ),

          const SizedBox(width: 10),
          Center(
            child: ElevatedButton(
              onPressed: _submit,
              child: const Text('Adicionar'),
            ),
          ),
        ],
      ),
    );
  }
}

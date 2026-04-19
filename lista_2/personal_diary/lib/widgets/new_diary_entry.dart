
import 'package:flutter/material.dart';
import 'package:personal_diary/models/event.dart';
import 'package:personal_diary/widgets/calendar_picker.dart';

class NewDiaryEntryForm extends StatefulWidget {
  final ValueChanged<DiaryEntry> onDiaryEntryAdded;

  const NewDiaryEntryForm({required this.onDiaryEntryAdded, super.key});

  @override
  State<NewDiaryEntryForm> createState() => _NewDiaryEntryFormState();
}

class _NewDiaryEntryFormState extends State<NewDiaryEntryForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _eventContentController;
  DateTime _selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _eventContentController = TextEditingController();
  }

  @override
  void dispose() {
    _eventContentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {

      final newDiaryEntry = DiaryEntry(
        content: _eventContentController.text.trim(),
        dateTime: _selectedDateTime,
      );
      widget.onDiaryEntryAdded(newDiaryEntry);
      _eventContentController.clear();
      setState(() {
        _selectedDateTime = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          CustomCalendarPicker(initialDate: DateTime.now(), onDateSelected: (date) {
            setState(() {
              _selectedDateTime = date;
            });
          }),

          TextFormField(
            controller: _eventContentController,
            decoration: const InputDecoration(
              labelText: 'Conteúdo do Diário',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira o conteúdo do diário';
              }
              return null;
            },
            minLines: 3,
            maxLines: 10,
          ),

          ElevatedButton(
            onPressed: _submit,
            child: const Text('Adicionar Entrada'),
          ),
        ],
      ),
    );
  }
}

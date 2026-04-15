import 'package:event_schedule/models/event.dart';
import 'package:event_schedule/utils/formatter.dart';
import 'package:flutter/material.dart';

class NewEventForm extends StatefulWidget {
  final ValueChanged<Event> onEventAdded;

  const NewEventForm({required this.onEventAdded, super.key});

  @override
  State<NewEventForm> createState() => _NewEventFormState();
}

class _NewEventFormState extends State<NewEventForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _eventNameController;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _eventNameController = TextEditingController();
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDateTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, escolha uma data')),
        );
        return;
      }

      final newEvent = Event(
        title: _eventNameController.text.trim(),
        dateTime: _selectedDateTime!,
      );
      widget.onEventAdded(newEvent);
      _eventNameController.clear();
      setState(() {
        _selectedDateTime = null;
      });
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted || pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDateTime = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          TextFormField(
            controller: _eventNameController,
            decoration: const InputDecoration(
              labelText: 'Nome do Evento',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira o nome do evento';
              }
              return null;
            },
          ),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today),
                label: const Text('Escolha uma data'),
              ),
              if (_selectedDateTime != null)
                Text(normalizeDateTime(_selectedDateTime!)),
              ElevatedButton(onPressed: _submit, child: const Text('Criar')),
            ],
          ),
        ],
      ),
    );
  }
}

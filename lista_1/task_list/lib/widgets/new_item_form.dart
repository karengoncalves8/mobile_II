import 'package:flutter/material.dart';
import 'package:task_list/enums/task_priority.dart';
import 'package:task_list/models/task_item.dart';

class NewItemForm extends StatefulWidget {
  final ValueChanged<TaskItem> onItemAdded;

  const NewItemForm({required this.onItemAdded, super.key});

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _taskNameController;
  late final TextEditingController _taskDescriptionController;
  TaskPriority _selectedPriority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController();
    _taskDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newItem = TaskItem(
        name: _taskNameController.text.trim(),
        description: _taskDescriptionController.text.trim(),
        priority: _selectedPriority,
      );
      widget.onItemAdded(newItem);
      _taskNameController.clear();
      _taskDescriptionController.clear();
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
            controller: _taskNameController,
            decoration: const InputDecoration(
              labelText: 'Nome da Tarefa',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira o nome da tarefa';
              }
              return null;
            },
          ),

          TextFormField(
            controller: _taskDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Descrição da Tarefa',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira a descrição da tarefa';
              }
              return null;
            },
          ),
          Text('Prioridade:'),
          RadioGroup(
            onChanged: (value) => setState(() => _selectedPriority = value!),
            groupValue: _selectedPriority,
            child: Column(
              children: [
                RadioListTile(
                  title: const Text('Baixa'),
                  value: TaskPriority.low,
                ),
                RadioListTile(
                  title: const Text('Média'),
                  value: TaskPriority.medium,
                ),
                RadioListTile(
                  title: const Text('Alta'),
                  value: TaskPriority.high,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Center(
            child: ElevatedButton(onPressed: _submit, child: const Text('Adicionar')),
          ),
        ],
      ),
    );
  }
}

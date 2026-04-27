import 'package:expenses_manager/domain/models/expense.dart';
import 'package:expenses_manager/domain/validators/expense_validators.dart';
import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({
    super.key,
    required this.onSubmit,
  });

  final ValueChanged<Expense> onSubmit;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final amount = double.parse(_amountController.text.trim());
    final description = _descriptionController.text.trim();

    widget.onSubmit(
      Expense(
        value: amount,
        description: description,
      ),
    );

    _formKey.currentState?.reset();
    _amountController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'New Expense',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                validator: ExpenseValidators.validateDescription,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Ex: Grocery market',
                  prefixIcon: Icon(Icons.description_outlined),
                  border: OutlineInputBorder(),
                ),
                maxLength: 80,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                validator: ExpenseValidators.validateAmount,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Ex: 29.90',
                  prefixIcon: Icon(Icons.attach_money_outlined),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _handleSubmit(),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _handleSubmit,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:expenses_manager/domain/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.separated(
        itemCount: expenses.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final expense = expenses[index];

          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.receipt_long_outlined),
            ),
            title: Text(expense.description),
            subtitle: Text('Expense #${index + 1}'),
            trailing: Text(
              '\$ ${expense.value.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        },
      ),
    );
  }
}

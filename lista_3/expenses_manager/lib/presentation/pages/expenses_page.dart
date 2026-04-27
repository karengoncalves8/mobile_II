import 'package:expenses_manager/domain/models/expense.dart';
import 'package:expenses_manager/presentation/controllers/expenses_controller.dart';
import 'package:expenses_manager/presentation/widgets/empty_expenses_state.dart';
import 'package:expenses_manager/presentation/widgets/expense_form.dart';
import 'package:expenses_manager/presentation/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({
    super.key,
    required this.controller,
  });

  final ExpensesController controller;

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.initialize();
  }

  Future<void> _addExpense(Expense expense) async {
    await widget.controller.addExpense(expense);
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense added successfully.')),
    );
  }

  Future<void> _clearExpenses() async {
    if (widget.controller.expenses.isEmpty) {
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.warning_amber_rounded),
          title: const Text('Erase all expenses?'),
          content: const Text(
            'This action will remove all saved expenses and cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Erase List'),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    await widget.controller.clearExpenses();
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expenses list erased.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Expenses Manager'),
            actions: [
              IconButton(
                tooltip: 'Erase expenses list',
                onPressed: widget.controller.expenses.isEmpty ? null : _clearExpenses,
                icon: const Icon(Icons.delete_sweep_outlined),
              ),
            ],
          ),
          body: SafeArea(
            child: widget.controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final isWideLayout = constraints.maxWidth >= 900;

                      if (isWideLayout) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: ExpenseForm(onSubmit: _addExpense),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  right: 16,
                                  bottom: 16,
                                ),
                                child: _ExpensesSection(
                                  expenses: widget.controller.expenses,
                                  totalAmount: widget.controller.totalAmount,
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          ExpenseForm(onSubmit: _addExpense),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 420,
                            child: _ExpensesSection(
                              expenses: widget.controller.expenses,
                              totalAmount: widget.controller.totalAmount,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _ExpensesSection extends StatelessWidget {
  const _ExpensesSection({
    required this.expenses,
    required this.totalAmount,
  });

  final List<Expense> expenses;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.summarize_outlined),
            title: const Text('Total Expenses'),
            subtitle: Text('${expenses.length} item(s)'),
            trailing: Text(
              '\$ ${totalAmount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: expenses.isEmpty
              ? const Card(child: EmptyExpensesState())
              : ExpensesList(expenses: expenses),
        ),
      ],
    );
  }
}

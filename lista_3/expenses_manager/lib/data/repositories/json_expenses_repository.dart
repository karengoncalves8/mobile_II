import 'dart:convert';
import 'dart:io';

import '../../domain/models/expense.dart';
import 'expense_repository.dart';

class JsonExpensesRepository implements ExpensesManagerProfileRepository {
  static const _fileName = 'expenses.json';

  Future<File> _resolveFile() async {
    final directory = Directory.current;
    final path = '${directory.path}${Platform.pathSeparator}$_fileName';
    return File(path);
  }

  @override
  Future<List<Expense>?> loadExpenses() async {
    final file = await _resolveFile();
    if (!await file.exists()) {
      return null;
    }

    final content = await file.readAsString();
    if (content.trim().isEmpty) {
      return null;
    }

    final decoded = jsonDecode(content) as Map<String, dynamic>;
    final expenses = (decoded['expenses'] as List<dynamic>? ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(Expense.fromJson)
        .toList();

    return expenses;
  }

  @override
  Future<void> saveExpense(Expense expense) async {
    final file = await _resolveFile();
    await file.parent.create(recursive: true);

    final currentExpenses = await loadExpenses() ?? <Expense>[];
    final updatedExpenses = [...currentExpenses, expense];

    final payload = {
      'expenses': updatedExpenses.map((e) => e.toJson()).toList(),
    };

    await file.writeAsString(jsonEncode(payload));
  }

  @override
  Future<void> clearExpenses() async {
    final file = await _resolveFile();
    if (await file.exists()) {
      await file.delete();
    }
  }
}

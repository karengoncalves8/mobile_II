import '../../domain/models/expense.dart';

abstract class ExpensesManagerProfileRepository {
  Future<List<Expense>?> loadExpenses();
  Future<void> saveExpense(Expense expense);
  Future<void> clearExpenses();
}

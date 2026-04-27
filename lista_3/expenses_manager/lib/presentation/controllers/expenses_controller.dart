import 'package:expenses_manager/data/repositories/expense_repository.dart';
import 'package:expenses_manager/domain/models/expense.dart';
import 'package:flutter/foundation.dart';

class ExpensesController extends ChangeNotifier {
  ExpensesController({required ExpensesManagerProfileRepository repository})
      : _repository = repository;

  final ExpensesManagerProfileRepository _repository;

  final List<Expense> _expenses = <Expense>[];

  bool _isLoading = false;

  List<Expense> get expenses => List.unmodifiable(_expenses);
  bool get isLoading => _isLoading;

  double get totalAmount =>
      _expenses.fold(0.0, (sum, expense) => sum + expense.value);

  Future<void> initialize() async {
    _setLoading(true);
    try {
      final data = await _repository.loadExpenses();
      _expenses
        ..clear()
        ..addAll(data ?? <Expense>[]);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addExpense(Expense expense) async {
    await _repository.saveExpense(expense);
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> clearExpenses() async {
    await _repository.clearExpenses();
    _expenses.clear();
    notifyListeners();
  }

  void _setLoading(bool value) {
    if (_isLoading == value) {
      return;
    }

    _isLoading = value;
    notifyListeners();
  }
}

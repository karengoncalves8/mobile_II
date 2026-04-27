import 'package:expenses_manager/data/repositories/json_expenses_repository.dart';
import 'package:expenses_manager/presentation/controllers/expenses_controller.dart';
import 'package:expenses_manager/presentation/pages/expenses_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpensesManagerApp());
}

class ExpensesManagerApp extends StatelessWidget {
  const ExpensesManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ExpensesController(repository: JsonExpensesRepository());

    return MaterialApp(
      title: 'Expenses Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.lightGreen,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF8FAFC),
        ),
      ),
      home: ExpensesPage(controller: controller),
    );
  }
}

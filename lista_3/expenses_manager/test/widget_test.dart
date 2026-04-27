import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:expenses_manager/main.dart';

void main() {
  testWidgets('renders expenses form and empty state',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ExpensesManagerApp());
    await tester.pump();

    expect(find.text('Expenses Manager'), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

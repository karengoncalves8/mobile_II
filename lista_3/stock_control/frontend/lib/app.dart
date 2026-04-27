import 'package:flutter/material.dart';
import 'package:frontend/domain/repositories/product_repository.dart';
import 'package:frontend/presentation/pages/stock_page.dart';

class StockControlApp extends StatelessWidget {
  const StockControlApp({super.key, required this.repository});

  final ProductRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: StockPage(repository: repository),
    );
  }
}

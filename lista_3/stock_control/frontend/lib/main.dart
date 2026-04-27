import 'package:flutter/widgets.dart';
import 'package:frontend/app.dart';
import 'package:frontend/data/repositories/http_product_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = HttpProductRepository(baseUrl: 'http://localhost:3000/api');

  runApp(StockControlApp(repository: repository));
}

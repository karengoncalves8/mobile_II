import 'package:arithmetic_mean/widget/arithmetic_mean_form.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Média Aritmética')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ArithmeticMeanForm(),
        ),
      ),
    );
  }
}

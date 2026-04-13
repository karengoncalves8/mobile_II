import 'package:flutter/material.dart';
import 'package:temperature_converter/widget/conversor_temperatura.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temperature Converter')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: ConversorTemperatura(),
      ),
    );
  }
}

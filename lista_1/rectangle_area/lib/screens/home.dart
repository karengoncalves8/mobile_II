import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _widthController;
  late final TextEditingController _heightController;

  double? rectArea;

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController();
    _heightController = TextEditingController();
  }

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        rectArea =
            double.parse(_widthController.text) *
            double.parse(_heightController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Área de Retângulo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 30,
          children: [
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Expanded(child: WidthInput(controller: _widthController)),
                  Expanded(child: HeightInput(controller: _heightController)),
                  ElevatedButton(
                    onPressed: onPressed,
                    child: const Text('Calcular Área'),
                  ),
                ],
              ),
            ),
            if (rectArea != null)
              Text(
                'Área do Retângulo: $rectArea',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WidthInput extends StatelessWidget {
  const WidthInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Largura',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira a largura';
        }
        if (double.tryParse(value) == null) {
          return 'Por favor, insira um número válido';
        }
        return null;
      },
    );
  }
}

class HeightInput extends StatelessWidget {
  const HeightInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Altura',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira a altura';
        }
        if (double.tryParse(value) == null) {
          return 'Por favor, insira um número válido';
        }
        return null;
      },
    );
  }
}

import 'package:flutter/material.dart';

class ArithmeticMeanForm extends StatefulWidget {
  const ArithmeticMeanForm({super.key});

  @override
  State<ArithmeticMeanForm> createState() => _ArithmeticMeanFormState();
}

class _ArithmeticMeanFormState extends State<ArithmeticMeanForm> {
  final _formKey = GlobalKey<FormState>();
  final List<double> _numbers = [];
  double? _mean;

  final values = ["Primeiro valor", "Segundo valor", "Terceiro valor"];

  void _calculateMean() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _mean = _numbers.reduce((a, b) => a + b) / _numbers.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            spacing: 10,
            children: [
              ...values.map(
                (valueLabel) => Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: valueLabel,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um número';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um número válido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _numbers.add(double.parse(value));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateMean,
            child: const Text('Calcular Média'),
          ),
          const SizedBox(height: 20),
          if (_mean != null)
            Text(
              'A média aritmética é: $_mean',
              style: const TextStyle(fontSize: 18),
            ),
        ],
      ),
    );
  }
}

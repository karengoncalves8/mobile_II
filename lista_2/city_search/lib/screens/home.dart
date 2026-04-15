import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> cities = [
    'Araraquara',
    'São Carlos',
    'Ribeirão Preto',
    'Bauru',
    'Marília',
  ];
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Cidades')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 50,
          children: [
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return cities.where((String city) {
                  return city.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  );
                });
              },
              onSelected: (String selection) {
                setState(() {
                  selectedCity = selection;
                });
              },
            ),
            Text(
              selectedCity != null ? 'Cidade selecionada: $selectedCity' : 'Nenhuma cidade selecionada',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

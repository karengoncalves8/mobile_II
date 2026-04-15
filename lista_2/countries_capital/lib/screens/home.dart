import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<String, String> countryCapitals = {
    'Brasil': 'Brasília',
    'Argentina': 'Buenos Aires',
    'Colômbia': 'Bogotá',
    'Peru': 'Lima',
    'Venezuela': 'Caracas',
  };
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
                return countryCapitals.keys.where((String country) {
                  return country.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  );
                });
              },
              onSelected: (String selection) {
                setState(() {
                  selectedCity = countryCapitals[selection];
                });
              },
            ),
            Text(
              selectedCity != null ? 'Capital do país selecionado: $selectedCity' : 'Nenhuma país selecionado',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fórmulario de Feedback')),
      body: Scrollable(
        viewportBuilder: (context, position) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 20,
              children: [
                Form(
                  child: Column(
                    spacing: 20,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Text("Como você avalia o serviço?"),
                      RadioGroup(
                        onChanged: (value) =>
                            setState(() => _selectedPriority = value!),
                        groupValue: _selectedPriority,
                        child: Column(
                          children: [
                            RadioListTile(
                              title: const Text('Excelente'),
                              value: "Excelente",
                            ),
                            RadioListTile(
                              title: const Text('Bom'),
                              value: "Bom",
                            ),
                            RadioListTile(
                              title: const Text('Ruim'),
                              value: "Ruim",
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Comentários',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Enviar Feedback'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

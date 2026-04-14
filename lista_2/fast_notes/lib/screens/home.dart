import 'package:fast_notes/models/note.dart';
import 'package:fast_notes/widgets/new_note_form.dart';
import 'package:fast_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Note> notes = [];

  void _addItem(Note item) {
    setState(() {
      notes.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Notas Rápidas')),
      body: Scrollable(
        viewportBuilder: (context, position) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 20,
              children: [
                NewNoteForm(onItemAdded: _addItem),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return NoteCard(note: note);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

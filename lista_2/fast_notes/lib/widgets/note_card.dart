import 'package:fast_notes/models/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text(
                widget.note.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              children: [ListTile(title: Text(widget.note.content))],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_diary/models/event.dart';
import 'package:personal_diary/widgets/calendar_picker.dart';
import 'package:personal_diary/widgets/new_diary_entry.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DiaryEntry> diary_entries = [];
  List<DiaryEntry> filted_diary_entries = [];

  List<DiaryEntry> filterByDate(DateTime date) {
    return diary_entries
        .where(
          (entry) =>
              entry.dateTime.year == date.year &&
              entry.dateTime.month == date.month &&
              entry.dateTime.day == date.day,
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    filted_diary_entries = filterByDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 60,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewDiaryEntryForm(
              onDiaryEntryAdded: (newEntry) {
                setState(() {
                  diary_entries.add(newEntry);
                  filted_diary_entries = filterByDate(DateTime.now());
                });
              },
            ),

            Wrap(
              spacing: 12,
              alignment: WrapAlignment.start,
              children: [
                Text('Escolha uma data para filtrar as entradas do diário:'),
                CustomCalendarPicker(
                  initialDate: DateTime.now(),
                  onDateSelected: (date) {
                    setState(() {
                      filted_diary_entries = filterByDate(date);
                    });
                  },
                ),
              ],
            ),

            if (filted_diary_entries.isEmpty)
              Center(child: Text('Nenhuma entrada encontrada para a data selecionada.')),

            Expanded(
              child: ListView.builder(
                itemCount: filted_diary_entries.length,
                itemBuilder: (context, index) {
                  final entry = filted_diary_entries[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.formattedDate,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(entry.content),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

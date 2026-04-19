import 'package:flutter/material.dart';
import 'package:personal_diary/utils/formatter.dart';

class CustomCalendarPicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const CustomCalendarPicker({
    required this.onDateSelected,
    required this.initialDate,
    super.key,
  });

  @override
  State<CustomCalendarPicker> createState() => _CustomCalendarPickerState();
}

class _CustomCalendarPickerState extends State<CustomCalendarPicker> {
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ;
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted || pickedDate == null) {
      return;
    }

    widget.onDateSelected(pickedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _pickDate,
          icon: const Icon(Icons.calendar_today),
          label: const Text('Escolha uma data'),
        ),
        if (_selectedDate != null) Text(normalizeDateTime(_selectedDate!)),
      ],
    );
  }
}

import 'package:attendence_list/domain/entities/attendance_person.dart';
import 'package:flutter/material.dart';

class AttendanceListItem extends StatelessWidget {
  const AttendanceListItem({
    super.key,
    required this.person,
    required this.onChanged,
    required this.onDelete,
  });

  final AttendancePerson person;
  final ValueChanged<bool> onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        key: ValueKey<int>(person.id),
        value: person.isPresent,
        onChanged: (bool? value) => onChanged(value ?? false),
        title: Text(person.name),
        subtitle: Text(person.isPresent ? 'Present' : 'Absent'),
        secondary: IconButton(
          onPressed: onDelete,
          tooltip: 'Remove',
          icon: const Icon(Icons.delete_outline),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

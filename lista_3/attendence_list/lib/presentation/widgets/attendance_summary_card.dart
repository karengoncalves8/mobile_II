import 'package:flutter/material.dart';

class AttendanceSummaryCard extends StatelessWidget {
  const AttendanceSummaryCard({
    super.key,
    required this.total,
    required this.present,
  });

  final int total;
  final int present;

  @override
  Widget build(BuildContext context) {
    final absent = total - present;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Summary', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                Chip(
                  avatar: const Icon(Icons.groups),
                  label: Text('Total: $total'),
                ),
                Chip(
                  avatar: const Icon(Icons.check_circle_outline),
                  label: Text('Present: $present'),
                ),
                Chip(
                  avatar: const Icon(Icons.cancel_outlined),
                  label: Text('Absent: $absent'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

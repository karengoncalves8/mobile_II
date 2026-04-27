import 'package:flutter/material.dart';

import '../../domain/models/registered_user.dart';

class SavedProfileCard extends StatelessWidget {
  const SavedProfileCard({
    super.key,
    required this.user,
  });

  final RegisteredUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saved Profile', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: Text(user.name),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.alternate_email),
              title: const Text('Email'),
              subtitle: Text(user.email),
            ),
          ],
        ),
      ),
    );
  }
}

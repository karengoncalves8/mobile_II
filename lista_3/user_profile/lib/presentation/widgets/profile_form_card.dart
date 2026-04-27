import 'package:flutter/material.dart';

class ProfileFormCard extends StatelessWidget {
  const ProfileFormCard({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.nameValidator,
    required this.emailValidator,
    required this.onSave,
    required this.onClear,
    required this.hasSavedProfile,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final String? Function(String?) nameValidator;
  final String? Function(String?) emailValidator;
  final VoidCallback onSave;
  final VoidCallback onClear;
  final bool hasSavedProfile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Register Account',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: nameValidator,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: emailValidator,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Save Register'),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: hasSavedProfile ? onClear : null,
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
                label: Text(
                  'Erase Register',
                  style: TextStyle(color: colorScheme.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

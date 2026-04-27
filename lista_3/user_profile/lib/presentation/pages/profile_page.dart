import 'package:flutter/material.dart';

import '../../domain/validators/profile_validators.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_form_card.dart';
import '../widgets/saved_profile_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_syncFormWithSavedProfile);
    widget.controller.initialize();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncFormWithSavedProfile);
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
  }

  void _syncFormWithSavedProfile() {
    final profile = widget.controller.savedProfile;
    if (profile == null) {
      _clearForm();
      return;
    }

    _nameController.text = profile.name;
    _emailController.text = profile.email;
  }

  Future<void> _save() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    await widget.controller.save(_nameController.text, _emailController.text);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully.')),
    );
  }

  Future<void> _clear() async {
    await widget.controller.clear();

    if (!mounted) {
      return;
    }

    _clearForm();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile erased. You can register again.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('User Register'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: widget.controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 800;

                      final formSection = ProfileFormCard(
                        formKey: _formKey,
                        nameController: _nameController,
                        emailController: _emailController,
                        nameValidator: ProfileValidators.validateName,
                        emailValidator: ProfileValidators.validateEmail,
                        onSave: _save,
                        onClear: _clear,
                        hasSavedProfile: widget.controller.hasProfile,
                      );

                      final saved = widget.controller.savedProfile;
                      final profileSection = saved == null
                          ? Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'No profile saved yet.',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            )
                          : SavedProfileCard(user: saved);

                      if (isWide) {
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1000),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: formSection),
                                  const SizedBox(width: 20),
                                  Expanded(child: profileSection),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            formSection,
                            const SizedBox(height: 16),
                            profileSection,
                          ],
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

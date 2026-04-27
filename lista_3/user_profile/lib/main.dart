import 'package:flutter/material.dart';

import 'data/repositories/json_profile_repository.dart';
import 'presentation/controllers/profile_controller.dart';
import 'presentation/pages/profile_page.dart';

void main() {
  runApp(const UserProfileApp());
}

class UserProfileApp extends StatelessWidget {
  const UserProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController(repository: JsonProfileRepository());

    return MaterialApp(
      title: 'User Profile Register',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF8FAFC),
        ),
      ),
      home: ProfilePage(controller: controller),
    );
  }
}

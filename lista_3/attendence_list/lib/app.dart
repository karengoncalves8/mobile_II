import 'package:attendence_list/domain/repositories/attendance_repository.dart';
import 'package:attendence_list/presentation/pages/attendance_page.dart';
import 'package:flutter/material.dart';

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key, required this.repository});

  final AttendanceRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: AttendancePage(repository: repository),
    );
  }
}

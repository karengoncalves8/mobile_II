import 'package:attendence_list/app.dart';
import 'package:attendence_list/core/database/database_initializer.dart';
import 'package:attendence_list/data/datasources/attendance_local_data_source.dart';
import 'package:attendence_list/data/repositories/attendance_repository_impl.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await DatabaseInitializer.open();
  final localDataSource = SqliteAttendanceLocalDataSource(database: database);
  final repository = AttendanceRepositoryImpl(localDataSource: localDataSource);

  runApp(AttendanceApp(repository: repository));
}

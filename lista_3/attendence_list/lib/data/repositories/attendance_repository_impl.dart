import 'package:attendence_list/data/datasources/attendance_local_data_source.dart';
import 'package:attendence_list/domain/entities/attendance_person.dart';
import 'package:attendence_list/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  AttendanceRepositoryImpl({required this.localDataSource});

  final AttendanceLocalDataSource localDataSource;

  @override
  Future<List<AttendancePerson>> getAllPeople() {
    return localDataSource.fetchAll();
  }

  @override
  Future<AttendancePerson> addPerson(String name) {
    return localDataSource.insertPerson(name);
  }

  @override
  Future<void> updatePresence({required int id, required bool isPresent}) {
    return localDataSource.updatePresence(id: id, isPresent: isPresent);
  }

  @override
  Future<void> deletePerson(int id) {
    return localDataSource.deletePerson(id);
  }
}

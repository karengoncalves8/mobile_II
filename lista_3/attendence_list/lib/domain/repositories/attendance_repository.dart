import 'package:attendence_list/domain/entities/attendance_person.dart';

abstract class AttendanceRepository {
  Future<List<AttendancePerson>> getAllPeople();
  Future<AttendancePerson> addPerson(String name);
  Future<void> updatePresence({required int id, required bool isPresent});
  Future<void> deletePerson(int id);
}

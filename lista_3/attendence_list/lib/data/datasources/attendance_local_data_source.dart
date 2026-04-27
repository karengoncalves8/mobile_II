import 'package:attendence_list/data/models/attendance_person_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class AttendanceLocalDataSource {
  Future<List<AttendancePersonModel>> fetchAll();
  Future<AttendancePersonModel> insertPerson(String name);
  Future<void> updatePresence({required int id, required bool isPresent});
  Future<void> deletePerson(int id);
}

class SqliteAttendanceLocalDataSource implements AttendanceLocalDataSource {
  SqliteAttendanceLocalDataSource({required this.database});

  final Database database;

  static const String _tableName = 'attendance_people';

  @override
  Future<List<AttendancePersonModel>> fetchAll() async {
    final rows = await database.query(
      _tableName,
      orderBy: 'name COLLATE NOCASE ASC',
    );

    return rows
        .map<AttendancePersonModel>(AttendancePersonModel.fromMap)
        .toList(growable: false);
  }

  @override
  Future<AttendancePersonModel> insertPerson(String name) async {
    final id = await database.insert(_tableName, <String, Object?>{
      'name': name,
      'is_present': 0,
    });

    return AttendancePersonModel(id: id, name: name, isPresent: false);
  }

  @override
  Future<void> updatePresence({
    required int id,
    required bool isPresent,
  }) async {
    await database.update(
      _tableName,
      <String, Object?>{'is_present': isPresent ? 1 : 0},
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
  }

  @override
  Future<void> deletePerson(int id) async {
    await database.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
  }
}

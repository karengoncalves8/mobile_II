import 'package:attendence_list/domain/entities/attendance_person.dart';

class AttendancePersonModel extends AttendancePerson {
  const AttendancePersonModel({
    required super.id,
    required super.name,
    required super.isPresent,
  });

  factory AttendancePersonModel.fromMap(Map<String, Object?> map) {
    return AttendancePersonModel(
      id: map['id'] as int,
      name: map['name'] as String,
      isPresent: (map['is_present'] as int) == 1,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'is_present': isPresent ? 1 : 0,
    };
  }
}

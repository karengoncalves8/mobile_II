class AttendancePerson {
  const AttendancePerson({
    required this.id,
    required this.name,
    required this.isPresent,
  });

  final int id;
  final String name;
  final bool isPresent;

  AttendancePerson copyWith({int? id, String? name, bool? isPresent}) {
    return AttendancePerson(
      id: id ?? this.id,
      name: name ?? this.name,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}

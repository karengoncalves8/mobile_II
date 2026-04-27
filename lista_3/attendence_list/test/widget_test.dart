import 'package:attendence_list/app.dart';
import 'package:attendence_list/domain/entities/attendance_person.dart';
import 'package:attendence_list/domain/repositories/attendance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('adds person and toggles attendance', (
    WidgetTester tester,
  ) async {
    final fakeRepository = _FakeAttendanceRepository();

    await tester.pumpWidget(AttendanceApp(repository: fakeRepository));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Alice');
    await tester.tap(find.text('Add to list'));
    await tester.pumpAndSettle();

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('Absent'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(find.text('Present'), findsOneWidget);
  });
}

class _FakeAttendanceRepository implements AttendanceRepository {
  final List<AttendancePerson> _people = <AttendancePerson>[];
  int _idSeed = 0;

  @override
  Future<AttendancePerson> addPerson(String name) async {
    final person = AttendancePerson(
      id: ++_idSeed,
      name: name,
      isPresent: false,
    );
    _people.add(person);
    return person;
  }

  @override
  Future<void> deletePerson(int id) async {
    _people.removeWhere((AttendancePerson person) => person.id == id);
  }

  @override
  Future<List<AttendancePerson>> getAllPeople() async {
    return _people.toList(growable: false)..sort(
      (AttendancePerson a, AttendancePerson b) => a.name.compareTo(b.name),
    );
  }

  @override
  Future<void> updatePresence({
    required int id,
    required bool isPresent,
  }) async {
    final index = _people.indexWhere(
      (AttendancePerson person) => person.id == id,
    );
    if (index == -1) {
      return;
    }
    _people[index] = _people[index].copyWith(isPresent: isPresent);
  }
}

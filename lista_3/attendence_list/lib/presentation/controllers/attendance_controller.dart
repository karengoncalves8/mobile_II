import 'package:attendence_list/domain/entities/attendance_person.dart';
import 'package:attendence_list/domain/repositories/attendance_repository.dart';
import 'package:flutter/foundation.dart';

class AttendanceController extends ChangeNotifier {
  AttendanceController({required this.repository});

  final AttendanceRepository repository;

  List<AttendancePerson> _people = <AttendancePerson>[];
  bool _isLoading = false;
  String? _errorMessage;

  List<AttendancePerson> get people => _people;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get presentCount =>
      _people.where((AttendancePerson person) => person.isPresent).length;

  Future<void> loadPeople() async {
    _setLoading(true);
    _setError(null);

    try {
      _people = await repository.getAllPeople();
    } catch (_) {
      _setError('Could not load attendance list.');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addPerson(String name) async {
    final cleanedName = name.trim();
    if (cleanedName.isEmpty) {
      _setError('Name cannot be empty.');
      notifyListeners();
      return false;
    }

    _setError(null);

    try {
      await repository.addPerson(cleanedName);
      _people = await repository.getAllPeople();
      notifyListeners();
      return true;
    } catch (_) {
      _setError('Could not save person.');
      notifyListeners();
      return false;
    }
  }

  Future<void> togglePresence(AttendancePerson person, bool isPresent) async {
    _setError(null);

    final original = _people;
    _people = _people
        .map(
          (AttendancePerson item) =>
              item.id == person.id ? item.copyWith(isPresent: isPresent) : item,
        )
        .toList(growable: false);
    notifyListeners();

    try {
      await repository.updatePresence(id: person.id, isPresent: isPresent);
    } catch (_) {
      _people = original;
      _setError('Could not update presence.');
      notifyListeners();
    }
  }

  Future<void> removePerson(int id) async {
    _setError(null);

    final previous = _people;
    _people = _people
        .where((AttendancePerson person) => person.id != id)
        .toList(growable: false);
    notifyListeners();

    try {
      await repository.deletePerson(id);
    } catch (_) {
      _people = previous;
      _setError('Could not remove person.');
      notifyListeners();
    }
  }

  void clearError() {
    _setError(null);
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
  }
}

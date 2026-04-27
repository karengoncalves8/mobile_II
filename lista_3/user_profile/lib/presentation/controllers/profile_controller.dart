import 'package:flutter/foundation.dart';

import '../../data/repositories/profile_repository.dart';
import '../../domain/models/registered_user.dart';

class ProfileController extends ChangeNotifier {
  ProfileController({required ProfileRepository repository}) : _repository = repository;

  final ProfileRepository _repository;

  bool _isLoading = true;
  RegisteredUser? _savedProfile;

  bool get isLoading => _isLoading;
  RegisteredUser? get savedProfile => _savedProfile;
  bool get hasProfile => _savedProfile != null;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      _savedProfile = await _repository.loadProfile();
    } catch (_) {
      _savedProfile = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> save(String name, String email) async {
    final profile = RegisteredUser(name: name.trim(), email: email.trim());
    await _repository.saveProfile(profile);
    _savedProfile = profile;
    notifyListeners();
  }

  Future<void> clear() async {
    await _repository.clearProfile();
    _savedProfile = null;
    notifyListeners();
  }
}

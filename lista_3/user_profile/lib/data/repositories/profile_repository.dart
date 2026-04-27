import '../../domain/models/registered_user.dart';

abstract class ProfileRepository {
  Future<RegisteredUser?> loadProfile();
  Future<void> saveProfile(RegisteredUser user);
  Future<void> clearProfile();
}

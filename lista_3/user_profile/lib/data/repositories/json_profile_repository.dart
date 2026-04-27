import 'dart:convert';
import 'dart:io';

import '../../domain/models/registered_user.dart';
import 'profile_repository.dart';

class JsonProfileRepository implements ProfileRepository {
  static const _fileName = 'registered_user.json';

  Future<File> _resolveFile() async {
    final directory = Directory.current;
    final path = '${directory.path}${Platform.pathSeparator}$_fileName';
    return File(path);
  }

  @override
  Future<RegisteredUser?> loadProfile() async {
    final file = await _resolveFile();
    if (!await file.exists()) {
      return null;
    }

    final content = await file.readAsString();
    if (content.trim().isEmpty) {
      return null;
    }

    final decoded = jsonDecode(content) as Map<String, dynamic>;
    return RegisteredUser.fromJson(decoded);
  }

  @override
  Future<void> saveProfile(RegisteredUser user) async {
    final file = await _resolveFile();
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode(user.toJson()));
  }

  @override
  Future<void> clearProfile() async {
    final file = await _resolveFile();
    if (await file.exists()) {
      await file.delete();
    }
  }
}

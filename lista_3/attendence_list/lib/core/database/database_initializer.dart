import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';

class DatabaseInitializer {
  static const String _databaseName = 'attendance.db';

  static Future<Database> open() async {
    if (!kIsWeb) {
      final isDesktop = switch (defaultTargetPlatform) {
        TargetPlatform.windows ||
        TargetPlatform.macOS ||
        TargetPlatform.linux => true,
        _ => false,
      };

      if (isDesktop) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }
    }

    final databasesPath = await databaseFactory.getDatabasesPath();
    final databasePath = p.join(databasesPath, _databaseName);

    return databaseFactory.openDatabase(
      databasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE attendance_people (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              is_present INTEGER NOT NULL DEFAULT 0
            )
          ''');
        },
      ),
    );
  }
}

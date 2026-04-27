import 'package:flutter/foundation.dart';

class ApiConfig {
  static const int _defaultPort = 3000;

  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:$_defaultPort/api';
    }

    return 'http://127.0.0.1:$_defaultPort/api';
  }
}

// lib/core/config/app_config.dart
import 'package:flutter/foundation.dart';

enum Environment { dev, prod }

class AppConfig {
  static late final Environment environment;
  static late final String apiUrl;
  static late final bool enableLogging;

  static void initialize(Environment env) {
    environment = env;

    switch (environment) {
      case Environment.dev:
        apiUrl = 'https://dev-api.example.com';
        enableLogging = true;
        break;
      case Environment.prod:
        apiUrl = 'https://api.example.com';
        enableLogging = false;
        break;
    }
  }

  static bool get isDevelopment => environment == Environment.dev;
}

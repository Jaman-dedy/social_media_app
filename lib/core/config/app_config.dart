// lib/core/config/app_config.dart
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

enum Environment { dev, staging, prod }

@singleton
class AppConfig {
  static late final Environment _environment;
  static late final Map<String, dynamic> _config;

  // App Names for different environments
  static late final String appName;
  static final String hiveBoxName = 'social_media_app';
  static final String hivePostsBox = 'posts';
  static final String hiveUsersBox = 'users';
  static final String hiveLikesBox = 'likes';
  static final String hiveCommentsBox = 'comments';

  // Firebase collections
  static const String usersCollection = 'users';
  static const String postsCollection = 'posts';
  static const String commentsCollection = 'comments';
  static const String likesCollection = 'likes';

  // Network timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration uploadTimeout = Duration(minutes: 5);
  static const Duration cacheDuration = Duration(hours: 24);

  // Feature flags
  static late final bool enablePushNotifications;
  static late final bool enableImageFilters;
  static late final bool enableStories;
  static late final bool enableBackgroundSync;
  static late final bool enableImageCompression;
  static late final bool enableOfflineMode;
  static late final bool enableEmailNotifications;

  static void initialize(Environment env) {
    _environment = env;
    _initializeConfig();
  }

  static void _initializeConfig() {
    switch (_environment) {
      case Environment.dev:
        _config = {
          'appName': 'FlutterSocial Dev',
          'enablePushNotifications': true,
          'enableImageFilters': true,
          'enableStories': true,
          'enableBackgroundSync': true,
          'enableImageCompression': true,
          'enableOfflineMode': true,
          'enableEmailNotifications': true,
        };
        break;

      case Environment.staging:
        _config = {
          'appName': 'FlutterSocial Staging',
          'enablePushNotifications': true,
          'enableImageFilters': true,
          'enableStories': true,
          'enableBackgroundSync': true,
          'enableImageCompression': true,
          'enableOfflineMode': true,
          'enableEmailNotifications': true,
        };
        break;

      case Environment.prod:
        _config = {
          'appName': 'FlutterSocial',
          'enablePushNotifications': true,
          'enableImageFilters': true,
          'enableStories': true,
          'enableBackgroundSync': true,
          'enableImageCompression': true,
          'enableOfflineMode': true,
          'enableEmailNotifications': true,
        };
        break;
    }

    _initializeValues();
  }

  static void _initializeValues() {
    appName = _config['appName'];
    enablePushNotifications = _config['enablePushNotifications'];
    enableImageFilters = _config['enableImageFilters'];
    enableStories = _config['enableStories'];
    enableBackgroundSync = _config['enableBackgroundSync'];
    enableImageCompression = _config['enableImageCompression'];
    enableOfflineMode = _config['enableOfflineMode'];
    enableEmailNotifications = _config['enableEmailNotifications'];
  }

  // Content limits
  static const int maxPostLength = 500;
  static const int maxCommentLength = 200;
  static const int maxCaptionLength = 150;
  static const int maxBioLength = 150;
  static const int maxDisplayNameLength = 50;
  static const int maxUsernameLength = 30;

  // Media configuration
  static const int maxImageSizeInMB = 5;
  static const int maxImageDimension = 2048;
  static const int imageQuality = 80;
  static const int thumbnailSize = 200;

  // Pagination
  static const int postsPerPage = 10;
  static const int commentsPerPage = 20;
  static const int maxCachedPosts = 100;

  // Utility getters
  static bool get isDevelopment => _environment == Environment.dev;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.prod;
  static Environment get environment => _environment;

  // Debug utilities
  static void printConfig() {
    if (isDevelopment) {
      debugPrint('=== App Configuration ===');
      debugPrint('Environment: $_environment');
      debugPrint('App Name: $appName');
      debugPrint('Feature Flags: ');
      debugPrint('- Push Notifications: $enablePushNotifications');
      debugPrint('- Image Filters: $enableImageFilters');
      debugPrint('- Stories: $enableStories');
      debugPrint('- Background Sync: $enableBackgroundSync');
      debugPrint('=======================');
    }
  }
}

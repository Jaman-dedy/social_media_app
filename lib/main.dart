// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'core/config/app_config.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'core/providers/providers.dart';
import 'app.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((_) {
      debugPrint('Firebase initialized successfully');
    }).catchError((error) {
      debugPrint('Firebase initialization error: $error');
    });

    // Initialize Hive
    await Hive.initFlutter();
    await _initializeHive();

    // Initialize app configuration
    AppConfig.initialize(Environment.dev);
  } catch (e, stackTrace) {
    debugPrint('Initialization error: $e');
    debugPrint('Stack trace: $stackTrace');
  }

  runApp(
    ProviderScope(
      overrides: [
        // Provide Firebase instances
        firebaseAuthProvider.overrideWithValue(FirebaseAuth.instance),
        firestoreProvider.overrideWithValue(FirebaseFirestore.instance),

        // Override the auth repository provider correctly
        authRepositoryProvider.overrideWith((ref) {
          final auth = ref.watch(firebaseAuthProvider);
          final firestore = ref.watch(firestoreProvider);
          return AuthRepositoryImpl(auth, firestore);
        }),
      ],
      child: const App(),
    ),
  );
}

Future<void> _initializeHive() async {
  try {
    await Hive.openBox(AppConfig.hiveBoxName);
    await Hive.openBox(AppConfig.hivePostsBox);
    await Hive.openBox(AppConfig.hiveUsersBox);
  } catch (e) {
    debugPrint('Hive initialization error: $e');
  }
}

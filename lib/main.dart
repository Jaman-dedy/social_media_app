import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart'; // Add this
import 'core/config/app_config.dart'; // Updated path
import 'core/theme/app_theme.dart'; // We'll create this
import 'presentation/screens/splash/splash_screen.dart'; // We'll create this

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize app configuration
    AppConfig.initialize(Environment.dev);

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Hive for local storage
    await Hive.initFlutter();

    // Register Hive adapters
    // We'll add these later: await registerHiveAdapters();

    // Initialize dependency injection
    // We'll implement this later: await configureDependencies();
  } catch (e) {
    debugPrint('Initialization error: $e');
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Social Media App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

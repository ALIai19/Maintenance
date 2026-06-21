import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/background_service.dart';
import 'core/utils/notification_service.dart';
import 'data/database/app_database.dart';
import 'presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();
  await BackgroundService.init();

  final database = AppDatabase();

  runApp(
    Provider<AppDatabase>(
      create: (_) => database,
      dispose: (_, db) => db.close(),
      child: const MedicalMaintenanceApp(),
    ),
  );
}

class MedicalMaintenanceApp extends StatelessWidget {
  const MedicalMaintenanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Maintenance',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: const Locale('ar', 'AE'),
      supportedLocales: const [
        Locale('ar', 'AE'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'data/activity_data.dart';
import 'repositories/activity_repository.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  final activityData = ActivityData();
  final activityRepository = ActivityRepository(activityData);
  final activityViewModel = ActivityViewModel(activityRepository);

  runApp(ActivityCounterApp(viewModel: activityViewModel));
}

class ActivityCounterApp extends StatelessWidget {
  final ActivityViewModel viewModel;

  const ActivityCounterApp({
    super.key,
    required this.viewModel,
  });

  static const Color primaryBerry = Color(0xFF9A005A);
  static const Color deepBerry = Color(0xFF68003C);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryBerry,
      primary: primaryBerry,
      secondary: const Color(0xFFD81B7A),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Activity Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF8F2F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBerry,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryBerry,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBerry,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: primaryBerry, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: primaryBerry.withValues(alpha: 0.25)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      home: HomeView(viewModel: viewModel),
    );
  }
}
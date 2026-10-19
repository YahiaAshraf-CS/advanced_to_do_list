import 'package:advanced_to_do_list/core/routes/app_routes.dart';
import 'package:advanced_to_do_list/view/screens/all_tasks_screen.dart';
import 'package:advanced_to_do_list/view/screens/calender_screen.dart';
import 'package:advanced_to_do_list/view/screens/documents_screen.dart';
import 'package:advanced_to_do_list/view/screens/home_screen.dart';
import 'package:advanced_to_do_list/view/screens/onboarding_screen.dart';
import 'package:advanced_to_do_list/view/screens/settings_screen.dart';
import 'package:advanced_to_do_list/view/screens/signin_screen.dart';
import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'view/widgets/main_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task & Calendar App',
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.allTasks: (context) => AllTasksScreen(),
        AppRoutes.calendar: (context) => CalendarScreen(),
        AppRoutes.settings: (context) => SettingsScreen(),
        AppRoutes.documents: (context) => DocumentsScreen(),
        AppRoutes.onboarding: (context) => OnboardingScreen(),
        AppRoutes.signup: (context) => SignInScreen(),
      },
    );
  }
}

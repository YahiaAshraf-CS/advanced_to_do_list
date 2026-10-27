import 'package:advanced_to_do_list/core/routes/app_routes.dart';
import 'package:advanced_to_do_list/view/screens/add_task_screen.dart';
import 'package:advanced_to_do_list/view/screens/all_tasks_screen.dart';
import 'package:advanced_to_do_list/view/screens/calender_screen.dart';
import 'package:advanced_to_do_list/view/screens/documents_screen.dart';
import 'package:advanced_to_do_list/view/screens/onboarding_screen.dart';
import 'package:advanced_to_do_list/view/screens/settings_screen.dart';
import 'package:advanced_to_do_list/view/screens/signin_screen.dart';
import 'package:advanced_to_do_list/view/screens/signup_screen.dart';
import 'package:advanced_to_do_list/view/widgets/main_navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasData) {
            return const MainNavigationScreen();
          }

          return const SignInScreen();
        },
      ),
      routes: {
        AppRoutes.home: (context) => const MainNavigationScreen(),
        AppRoutes.allTasks: (context) => const AllTasksScreen(),
        AppRoutes.calendar: (context) => const CalendarScreen(),
        AppRoutes.settings: (context) => const SettingsScreen(),
        AppRoutes.documents: (context) => const DocumentsScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.signup: (context) => const SignUpScreen(),
        AppRoutes.addTask: (context) => const AddTaskScreen(),
        AppRoutes.login: (context) => const SignInScreen(),
      },
    );
  }
}
import 'package:advanced_to_do_list/core/routes/app_routes.dart';
import 'package:advanced_to_do_list/features/tasks/data/notefication/notification_service.dart';
import 'package:advanced_to_do_list/view/screens/add_custom_category_screen.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
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
      home: const AuthGate(),
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
        AppRoutes.addCustomCategory: (context) => const AddCustomCategoryScreen(),
      },
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final Stream<User?> _authStream;

  @override
  void initState() {
    super.initState();

    _authStream = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Something went wrong. Please restart the app.',
              ),
            ),
          );
        }

        if (snapshot.data != null) {
          return const MainNavigationScreen();
        }

        return const SignInScreen();
      },
    );
  }
}

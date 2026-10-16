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
      home: const MainNavigationScreen(),
    );
  }
}
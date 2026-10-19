import 'package:advanced_to_do_list/core/routes/app_routes.dart';
import 'package:advanced_to_do_list/view/screens/documents_screen.dart';
import 'package:advanced_to_do_list/view/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../screens/home_screen.dart';
import '../screens/all_tasks_screen.dart';
import '../screens/calender_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  String currentRoute = AppRoutes.home;

  int get currentIndex {
    switch (currentRoute) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.calendar:
        return 1;
      case AppRoutes.allTasks:
        return 2;
      case AppRoutes.documents:
        return 3;
      case AppRoutes.settings:
        return 4;
      default:
        return 0;
    }
  }

  final List<Widget> screens = const [
    HomeScreen(),
    CalendarScreen(),
    AllTasksScreen(),
    DocumentsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isAllTasks = currentRoute == AppRoutes.allTasks;

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: currentIndex, children: screens),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isAllTasks) {
            setState(() {
              currentRoute = AppRoutes.allTasks;
            });
          }
        },
        shape: const CircleBorder(),
        child: Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: isAllTasks
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomAppBar(
          color: AppColors.white,
          elevation: 0,
          shape: isAllTasks ? null : const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(Icons.home_outlined, AppRoutes.home),
              navItem(Icons.calendar_month_outlined, AppRoutes.calendar),
              const SizedBox(width: 48),
              navItem(Icons.description_outlined, AppRoutes.documents),
              navItem(Icons.settings_outlined, AppRoutes.settings),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String routeName) {
    final isSelected = currentRoute == routeName;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentRoute = routeName;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.secondaryText,
            size: 26,
          ),
        ),
      ),
    );
  }
}

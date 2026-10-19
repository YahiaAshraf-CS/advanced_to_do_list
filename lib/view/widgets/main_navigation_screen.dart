import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../screens/all_tasks_screen.dart';
import '../screens/calender_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  late final List<Widget> screens = [
    const AllTasksScreen(),
    const CalendarScreen(),
    const Center(child: Text('Documents Screen')),
    const Center(child: Text('Settings Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    final isTasksPage = currentIndex == 0;

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: isTasksPage
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
          shape: isTasksPage
              ? const AutomaticNotchedShape(
                  RoundedRectangleBorder(),
                  StadiumBorder(),
                )
              : const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navItem(Icons.home_outlined, 0),
              navItem(Icons.calendar_month_outlined, 1),
              const SizedBox(width: 48),
              navItem(Icons.description_outlined, 2),
              navItem(Icons.settings_outlined, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, int index) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
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

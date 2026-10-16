import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../widgets/task_card.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All tasks',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Overdue',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.overdue,
            ),
          ),
          const SizedBox(height: 12),
          const TaskCard(
            title: 'Finish Report',
            date: 'Thu, 7 Sept 2023',
            isOverdue: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'All Tasks',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                TaskCard(
                  title: 'Read Book',
                  date: 'Thu, 7 Sept 2023',
                ),
                TaskCard(
                  title: 'Water Plants',
                  date: 'Thu, 7 Sept 2023',
                ),
                TaskCard(
                  title: 'Walk the dogs',
                  date: 'Thu, 7 Sept 2023',
                ),
                TaskCard(
                  title: 'Finish Report',
                  date: 'Thu, 7 Sept 2023',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
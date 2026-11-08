import 'package:advanced_to_do_list/features/tasks/data/models/task_model.dart';
import 'package:advanced_to_do_list/features/tasks/data/services/task_servies.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

import '../widgets/calendar_task_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final TaskService _taskService = TaskService();

  DateTime displayedMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();

  void changeMonth(int amount) {
    setState(() {
      displayedMonth = DateTime(
        displayedMonth.year,
        displayedMonth.month + amount,
      );
      selectedDate = DateTime(
        displayedMonth.year,
        displayedMonth.month,
        1,
      );
    });
  }

  String get monthName {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[displayedMonth.month - 1];
  }

  // تنسيق التاريخ ليتطابق مع الشكل المخزن في قاعدة البيانات (مثال: Thu, 7 Sep 2023 أو ما شابه حسب تنسيقك)
  // سنقوم بمطابقة اليوم والشهر والسنة
  bool isSameDate(DateTime date, String taskDateStr) {
    // تنسيق التاريخ المختار لنقارنه بالنص المخزن
    // أو يمكننا مطابقة الأجزاء (Day, Month Name, Year)
    try {
      // مثال بسيط للمقارنة: التأكد من أن النص يحتوي على رقم اليوم والشهر والسنة
      final dayStr = date.day.toString();
      final yearStr = date.year.toString();
      return taskDateStr.contains(dayStr) && taskDateStr.contains(yearStr);
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(
      displayedMonth.year,
      displayedMonth.month,
      1,
    );

    final daysInMonth = DateTime(
      displayedMonth.year,
      displayedMonth.month + 1,
      0,
    ).day;

    final startingOffset = firstDay.weekday % 7;
    final totalCells = ((startingOffset + daysInMonth + 6) ~/ 7) * 7;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          const Center(
            child: Text(
              'Calendar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => changeMonth(-1),
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  '${selectedDate.day} $monthName ${displayedMonth.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF858B96),
                  ),
                ),
                IconButton(
                  onPressed: () => changeMonth(1),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // Compact weekday container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.07),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
                    .map(
                      (day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF606775),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: totalCells,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 6,
                crossAxisSpacing: 4,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) {
                final dayNumber = index - startingOffset + 1;

                if (dayNumber < 1 || dayNumber > daysInMonth) {
                  return const SizedBox.shrink();
                }

                final isSelected = selectedDate.year == displayedMonth.year &&
                    selectedDate.month == displayedMonth.month &&
                    selectedDate.day == dayNumber;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = DateTime(
                        displayedMonth.year,
                        displayedMonth.month,
                        dayNumber,
                      );
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$dayNumber',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w600,
                        color:
                            isSelected ? Colors.white : const Color(0xFF202124),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Tasks for the selected date from Firestore
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: StreamBuilder<List<TaskModel>>(
              stream: _taskService.getUserTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Text('Error loading tasks for calendar.');
                }

                final allTasks = snapshot.data ?? [];

                // تصفية المهام بناءً على اليوم المختار
                final selectedDayTasks = allTasks.where((task) {
                  return isSameDate(selectedDate, task.date);
                }).toList();

                if (selectedDayTasks.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'No tasks for this date.',
                        style:
                            TextStyle(color: Color(0xFF858B96), fontSize: 15),
                      ),
                    ),
                  );
                }

                return Column(
                  children: selectedDayTasks
                      .map(
                        (task) => CalendarTaskCard(
                          date: task.date,
                          time: task.time,
                          title: task.title,
                          onDelete: () async {
                            await _taskService.deleteTask(task.id);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('"${task.title}" deleted'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

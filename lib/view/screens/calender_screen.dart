import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../widgets/calendar_task_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime displayedMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();

  final List<_CalendarTask> tasks = [
    _CalendarTask(title: 'Finish Report', time: '09:45 AM'),
    _CalendarTask(title: 'Water the plants', time: '10:00 AM'),
  ];

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
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December',
    ];
    return months[displayedMonth.month - 1];
  }

  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
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
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
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

                final isSelected =
                    selectedDate.year == displayedMonth.year &&
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
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$dayNumber',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF202124),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Tasks for the selected date
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Column(
              children: tasks
                  .map(
                    (task) => CalendarTaskCard(
                      date: formatDate(selectedDate),
                      time: task.time,
                      title: task.title,
                      onDelete: () {
                        setState(() {
                          tasks.remove(task);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${task.title} deleted'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _CalendarTask {
  final String title;
  final String time;

  _CalendarTask({
    required this.title,
    required this.time,
  });
}
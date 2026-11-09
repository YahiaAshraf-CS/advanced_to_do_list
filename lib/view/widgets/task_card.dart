import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../../theme/app_colors.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String date;
  final String category;
  final String iconName;
  final Color categoryColor;
  final bool isOverdue;
  final bool isCompleted;

  const TaskCard({
    super.key,
    required this.title,
    required this.date,
    required this.category,
    required this.iconName,
    required this.categoryColor,
    this.isOverdue = false,
    this.isCompleted = false,
  });

  IconData _getCategoryIcon(String name) {
    final Map<String, IconData> iconsMap = {
      'folder': Icons.folder_outlined,
      'star': Icons.star_outline,
      'work': Icons.work_outline,
      'home': Icons.home_outlined,
      'fitness': Icons.fitness_center,
      'code': Icons.code,
      'book': Icons.book_outlined,
      'flight': Icons.flight,
      'quran': FlutterIslamicIcons.quran2,
      'mosque': FlutterIslamicIcons.mosque,
      'prayer': FlutterIslamicIcons.prayer,
      'school': Icons.school_outlined,
      'science': Icons.science_outlined,
      'shopping': Icons.shopping_cart_outlined,
      'favorite': Icons.favorite_border,
      'sports': Icons.sports_soccer,
      'music': Icons.music_note_outlined,
      'movie': Icons.movie_outlined,
      'palette': Icons.palette_outlined,
      'business': Icons.business_center_outlined,
      'money': Icons.attach_money,
      'food': Icons.restaurant_outlined,
      'coffee': Icons.coffee_outlined,
      'pets': Icons.pets,
      'car': Icons.directions_car_outlined,
      'other': Icons.category_outlined,
    };
    return iconsMap[name] ?? Icons.folder_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.taskBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      _getCategoryIcon(iconName),
                      size: 16,
                      color: categoryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: categoryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        isOverdue ? AppColors.overdue : AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

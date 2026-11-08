import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Color borderColor;

  const CategoryWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

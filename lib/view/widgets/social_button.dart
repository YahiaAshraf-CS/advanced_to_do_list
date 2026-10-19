import 'package:advanced_to_do_list/theme/app_colors.dart';
import 'package:flutter/material.dart';
 

class SocialButton extends StatelessWidget {
  final Widget icon;
  final Color bgColor;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Center(child: icon),
      ),
    );
  }
}

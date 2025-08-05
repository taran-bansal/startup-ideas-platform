import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? iconColor;
  final double iconSize;
  final double fontSize;

  const StatItem({
    Key? key,
    required this.icon,
    required this.value,
    this.iconColor,
    this.iconSize = 16,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor ?? AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: fontSize,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';

class VoteButton extends StatelessWidget {
  final int voteCount;
  final VoidCallback onVote;
  final bool isVoted;
  final bool isSmall;

  const VoteButton({
    Key? key,
    required this.voteCount,
    required this.onVote,
    this.isVoted = false,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onVote,
          icon: Icon(
            Icons.arrow_upward_rounded,
            color: isVoted ? AppColors.primary : AppColors.textSecondary,
            size: isSmall ? 20 : 24,
          ),
          style: IconButton.styleFrom(
            backgroundColor: isVoted
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.backgroundSecondary,
            padding: EdgeInsets.all(isSmall ? 6 : 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: isVoted
                    ? AppColors.primary.withOpacity(0.3)
                    : Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _formatCount(voteCount),
          style: GoogleFonts.inter(
            fontSize: isSmall ? 12 : 14,
            fontWeight: isSmall ? FontWeight.w500 : FontWeight.w600,
            color: isVoted ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

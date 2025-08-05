import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import 'vote_button.dart';
import 'stat_item.dart';

class IdeaCard extends StatelessWidget {
  final String id;
  final String title;
  final String tagline;
  final String description;
  final String? imageUrl;
  final double rating;
  final int votes;
  final bool isVoted;
  final VoidCallback onVote;
  final VoidCallback? onTap;

  const IdeaCard({
    Key? key,
    required this.id,
    required this.title,
    required this.tagline,
    required this.description,
    this.imageUrl,
    this.rating = 0.0,
    this.votes = 0,
    this.isVoted = false,
    required this.onVote,
    this.onTap,
  }) : super(key: key);

  factory IdeaCard.fromIdeaModel(
    dynamic idea, {
    required bool isVoted,
    required VoidCallback onVote,
    VoidCallback? onTap,
  }) {
    return IdeaCard(
      id: idea.id,
      title: idea.title,
      tagline: idea.tagline,
      description: idea.description,
      imageUrl: idea.imageUrl,
      rating: idea.rating,
      votes: idea.votes,
      isVoted: isVoted,
      onVote: onVote,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 80,
                          color: AppColors.backgroundSecondary,
                          child: const Icon(Icons.broken_image, color: AppColors.textSecondary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tagline,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description.length > 100
                              ? '${description.substring(0, 100)}...'
                              : description,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  VoteButton(
                    voteCount: votes,
                    isVoted: isVoted,
                    onVote: onVote,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  StatItem(
                    icon: Icons.star_rate_rounded,
                    value: rating.toStringAsFixed(1),
                    iconColor: Colors.amber,
                  ),
                  const SizedBox(width: 16),
                  StatItem(
                    icon: Icons.thumb_up_alt_outlined,
                    value: votes.toString(),
                  ),
                  const Spacer(),
                  Text(
                    'Read More',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

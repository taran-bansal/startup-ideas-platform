import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/idea_model.dart';
import '../../../widgets/custom_app_bar.dart';
import '../controllers/leaderboard_controller.dart';

class LeaderboardScreen extends GetView<LeaderboardController> {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Leaderboard',
        showBackButton: false,
      ),
      body: Obx(() {
        if (controller.isLoading && controller.topIdeas.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if ((controller.error?.isNotEmpty ?? false) && controller.topIdeas.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load leaderboard',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.fetchTopIdeas,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.topIdeas.isEmpty) {
          return Center(
            child: Text(
              'No ideas yet. Be the first to submit one!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshIdeas,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemCount: controller.topIdeas.length,
            itemBuilder: (context, index) {
              final idea = controller.topIdeas[index];
              return _LeaderboardCard(
                idea: idea,
                rank: index + 1,
                onTap: () => _navigateToIdeaDetail(idea),
              );
            },
          ),
        );
      }),
    );
  }

  void _navigateToIdeaDetail(IdeaModel idea) {
    // Navigate to idea detail screen
    // Get.toNamed('/idea-detail', arguments: idea.id);
  }
}

class _LeaderboardCard extends StatelessWidget {
  final IdeaModel idea;
  final int rank;
  final VoidCallback onTap;

  const _LeaderboardCard({
    Key? key,
    required this.idea,
    required this.rank,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRankBadge(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      idea.title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      idea.tagline,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (idea.imageUrl != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: idea.imageUrl!,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 120,
                            color: AppColors.backgroundSecondary,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 120,
                            color: AppColors.backgroundSecondary,
                            child: const Icon(Icons.broken_image, color: AppColors.textSecondary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Row(
                      children: [
                        _buildStatItem(
                          Icons.star_rate_rounded,
                          '${idea.rating.toStringAsFixed(1)}',
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 16),
                        _buildStatItem(
                          Icons.thumb_up_alt_outlined,
                          '${idea.votes}',
                        ),
                        const Spacer(),
                        Text(
                          'View Details',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankBadge() {
    Color badgeColor;
    Color textColor = Colors.white;
    
    switch (rank) {
      case 1:
        badgeColor = const Color(0xFFFFD700); // Gold
        break;
      case 2:
        badgeColor = const Color(0xFFC0C0C0); // Silver
        break;
      case 3:
        badgeColor = const Color(0xFFCD7F32); // Bronze
        break;
      default:
        badgeColor = AppColors.backgroundSecondary;
        textColor = AppColors.textSecondary;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '#$rank',
          style: GoogleFonts.inter(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

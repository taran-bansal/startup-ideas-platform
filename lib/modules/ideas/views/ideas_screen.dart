import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/idea_model.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/idea_card.dart';
import '../../../widgets/sort_chip.dart';
import '../controllers/idea_controller.dart';

class IdeasScreen extends GetView<IdeaController> {
  const IdeasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ideas',
        showBackButton: false,
      ),
      body: Column(
        children: [
          _buildSortOptions(),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              if (controller.isLoading && controller.ideas.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error != null && controller.ideas.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Failed to load ideas',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: controller.fetchIdeas,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.ideas.isEmpty) {
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
                  itemCount: controller.ideas.length,
                  itemBuilder: (context, index) {
                    final idea = controller.ideas[index];
                    return IdeaCard.fromIdeaModel(
                      idea,
                      isVoted: false, // In a real app, check if current user has voted
                      onVote: () => _handleVote(idea),
                      onTap: () => _navigateToIdeaDetail(idea),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToSubmitIdea,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSortOptions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => SortChip(
                label: 'Rating',
                isSelected: controller.sortBy.value == 'rating',
                isAscending: controller.isAscending.value,
                onTap: () => controller.setSort('rating'),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Obx(
              () => SortChip(
                label: 'Votes',
                isSelected: controller.sortBy.value == 'votes',
                isAscending: controller.isAscending.value,
                onTap: () => controller.setSort('votes'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleVote(IdeaModel idea) {
    // In a real app, you would pass the current user's ID
    controller.toggleVote(idea, 'current_user_id');
  }

  void _navigateToIdeaDetail(IdeaModel idea) {
    // Navigate to idea detail screen
    // Get.toNamed('/idea-detail', arguments: idea.id);
  }

  void _navigateToSubmitIdea() async {
    final result = await Get.toNamed('/submit-idea');
    if (result == true) {
      await controller.refreshIdeas();
    }
  }
}

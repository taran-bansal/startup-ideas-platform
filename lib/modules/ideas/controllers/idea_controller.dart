import 'package:get/get.dart';
import '../../../core/controllers/base_controller.dart';
import '../../../data/models/idea_model.dart';
import '../../../data/repositories/idea_repository.dart';

class IdeaController extends BaseController {
  final IdeaRepository _repository;
  
  IdeaController(this._repository);
  
  final RxList<IdeaModel> ideas = <IdeaModel>[].obs;
  final RxString sortBy = 'rating'.obs;
  final RxBool isAscending = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchIdeas();
    
    // React to sort and filter changes
    everAll([sortBy, isAscending, searchQuery], (_) => fetchIdeas());
  }

  Future<void> fetchIdeas() async {
    try {
      setLoading(true);
      setError(null);
      
      if (searchQuery.value.isNotEmpty) {
        final results = await _repository.searchIdeas(searchQuery.value);
        ideas.assignAll(results);
      } else {
        final results = await _repository.getIdeas(
          sortBy: sortBy.value,
          ascending: isAscending.value,
        );
        ideas.assignAll(results);
      }
    } catch (e) {
      setError('Failed to load ideas. Please try again.');
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> refreshIdeas() async {
    await fetchIdeas();
  }

  Future<void> toggleVote(IdeaModel idea, String userId) async {
    try {
      setLoading(true);
      // In a real app, you would track which ideas the user has voted on
      final hasVoted = idea.votes % 2 == 1; // Simplified for demo
      
      await _repository.voteIdea(
        idea.id,
        userId,
        upvote: !hasVoted,
      );
      
      await fetchIdeas();
    } catch (e) {
      setError('Failed to update vote. Please try again.');
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void setSort(String newSortBy) {
    if (sortBy.value == newSortBy) {
      isAscending.toggle();
    } else {
      sortBy.value = newSortBy;
      isAscending.value = false;
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}

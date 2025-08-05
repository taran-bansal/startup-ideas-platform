import 'package:get/get.dart';
import '../../../core/controllers/base_controller.dart';
import '../../../data/models/idea_model.dart';
import '../../../data/repositories/idea_repository.dart';

class LeaderboardController extends BaseController {
  final IdeaRepository _repository;
  
  LeaderboardController(this._repository);
  
  final RxList<IdeaModel> topIdeas = <IdeaModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopIdeas();
  }

  Future<void> fetchTopIdeas() async {
    try {
      setLoading(true);
      setError(null);
      
      // Get top 10 ideas by rating
      final ideas = await _repository.getIdeas(
        sortBy: 'rating',
        ascending: false,
      );
      
      topIdeas.assignAll(ideas.take(10).toList());
    } catch (e) {
      setError(e.toString());
      Get.snackbar('Error', 'Failed to load leaderboard. Please try again.');
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> refreshIdeas() async {
    await fetchTopIdeas();
  }

  @override
  void onClose() {
    topIdeas.close();
    super.onClose();
  }
}

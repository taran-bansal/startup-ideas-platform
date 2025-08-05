import 'package:get/get.dart';
import '../../data/repositories/idea_repository.dart';
import '../../modules/home/controllers/submit_idea_controller.dart';
import '../../modules/ideas/controllers/idea_controller.dart';
import '../../modules/leaderboard/controllers/leaderboard_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialize repositories
    final repository = Get.put<IdeaRepository>(MockIdeaRepository(), permanent: true);
    
    // Initialize controllers
    Get.lazyPut(() => IdeaController(repository));
    Get.lazyPut(() => LeaderboardController(repository));
    Get.lazyPut(() => SubmitIdeaController(repository));
  }
}

class IdeasBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MockIdeaRepository());
    final repository = Get.find<MockIdeaRepository>();
    Get.lazyPut(() => IdeaController(repository));
  }
}

class LeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    final repository = Get.find<MockIdeaRepository>();
    Get.lazyPut(() => LeaderboardController(repository));
  }
}

class SubmitIdeaBinding extends Bindings {
  @override
  void dependencies() {
    final repository = Get.find<MockIdeaRepository>();
    Get.lazyPut(() => SubmitIdeaController(repository));
  }
}

import 'package:get/get.dart';

import '../../modules/home/views/submit_idea_screen.dart';
import '../../modules/ideas/views/ideas_screen.dart';
import '../../modules/leaderboard/views/leaderboard_screen.dart';
import '../bindings/app_bindings.dart';

abstract class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const IdeasScreen(),
      binding: IdeasBinding(),
    ),
    GetPage(
      name: _Paths.submitIdea,
      page: () => const SubmitIdeaScreen(),
      binding: SubmitIdeaBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.leaderboard,
      page: () => const LeaderboardScreen(),
      binding: LeaderboardBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}

abstract class Routes {
  static const home = _Paths.home;
  static const submitIdea = _Paths.submitIdea;
  static const leaderboard = _Paths.leaderboard;
}

abstract class _Paths {
  static const home = '/';
  static const submitIdea = '/submit-idea';
  static const leaderboard = '/leaderboard';
}

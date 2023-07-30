import 'package:get/get.dart';
import 'package:quiz/presentation/controllers/controllers.dart';
import 'package:quiz/presentation/pages/auth_and_profile/login_screen.dart';
import 'package:quiz/presentation/pages/auth_and_profile/profile_screen.dart';
import 'package:quiz/presentation/pages/home/home_screen.dart';
import 'package:quiz/presentation/pages/leaderboard/leaderboard_screen.dart';
import 'package:quiz/presentation/pages/onboarding/app_indroduction_screen.dart';
import 'package:quiz/presentation/pages/quiz/answer_check_screen.dart';
import 'package:quiz/presentation/pages/quiz/quiz_overview_screen.dart';
import 'package:quiz/presentation/pages/quiz/quiz_screen.dart';
import 'package:quiz/presentation/pages/quiz/result_screen.dart';
import 'package:quiz/presentation/pages/splash/splash.dart';


class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const SplashScreen(),
          name: SplashScreen.routeName,
        ),
        GetPage(
          page: () => const AppIntroductionScreen(),
          name: AppIntroductionScreen.routeName,
        ),
        GetPage(
            page: () => const HomeScreen(),
            name: HomeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(MyDrawerController());
            })),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
        GetPage(
            page: () => const ProfileScreen(),
            name: ProfileScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(ProfileController());
            })),
        GetPage(
            page: () => LeaderBoardScreen(),
            name: LeaderBoardScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(LeaderBoardController());
            })),
        GetPage(
            page: () => const QuizeScreen(),
            name: QuizeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<QuizController>( QuizController());
            })),
        GetPage(
            page: () => const AnswersCheckScreen(),
            name: AnswersCheckScreen.routeName),
        GetPage(
            page: () => const QuizOverviewScreen(),
            name: QuizOverviewScreen.routeName),
        GetPage(page: () => const ResultScreen(), name: ResultScreen.routeName),
      ];
}

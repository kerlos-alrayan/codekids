import 'package:codekids/features/auth/presentation/views/sign_up_steps.dart';
import 'package:codekids/features/home/presentation/views/bottom_nav_bar.dart';
import 'package:codekids/features/introduction/presentation/views/widgets/auth_choice_view.dart';
import 'package:codekids/features/notification/presentation/views/notification_view.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/auth_checker.dart';
import '../../features/auth/presentation/views/widgets/sign_in_view.dart';
import '../../features/games/presentation/views/quiz_game.dart';
import '../../features/games/presentation/views/help_robot_game.dart';
import '../../features/games/presentation/views/sorting_game.dart';
import '../../features/games/presentation/views/widgets/win_screen.dart';
import '../../features/introduction/presentation/views/introduction_view.dart';
import '../../features/introduction/presentation/views/widgets/loginCode.dart';
import '../../features/introduction/presentation/views/widgets/sign_in_view_kids.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kAuthChecker = '/auth-checker';
  static const  kAuthChoiceView = '/auth_choice_view';
  static const kIntroductionView = '/IntroductionView';
  static const kSignInViewKids = '/sign_in_view_kids';
  static const kLoginCodePage = '/loginCode';
  static const kSignUpSteps = '/SignUpSteps';
  static const kSignInView = '/SignInView';
  static const kBottomNavBar = '/BottomNavBar';
  static const kNotifications = '/Notifications';
  static const kSortingGame = '/SortingGame';
  static const kQuizGame = '/QuizGame';
  static const kHelpRobotGame = '/HelpRobotGame';
  static const kWinScreen = '/WinScreen';

  static final GoRouter router = GoRouter(
    initialLocation: kSplashView,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kAuthChecker,
        builder: (context, state) => const AuthChecker(),
      ),
      GoRoute(
        path: kAuthChoiceView,
        builder: (context, state) => const AuthChoiceView(),
      ),

      GoRoute(
        path: kIntroductionView,
        builder: (context, state) => const IntroductionView(),
      ),
      GoRoute(
        path: kLoginCodePage,
        builder: (context, state) => const LoginCodePage(),
      ),
      GoRoute(
        path: kSignInViewKids,
        builder: (context, state) => SignInViewKids(),
      ),

      GoRoute(
        path: kSignUpSteps,
        builder: (context, state) => const SignUpSteps(totalSteps: 8),
      ),
      GoRoute(
        path: kSignInView,
        builder: (context, state) => SignInView(),
      ),
      GoRoute(
        path: kBottomNavBar,
        builder: (context, state) => BottomNavBar(),
      ),
      GoRoute(
        path: kNotifications,
        builder: (context, state) => NotificationView(),
      ),
      GoRoute(
        path: kSortingGame,
        builder: (context, state) => SortingGame(),
      ),
      GoRoute(
        path: kQuizGame,
        builder: (context, state) => QuizGame(),
      ),
      GoRoute(
        path: kHelpRobotGame,
        builder: (context, state) => HelpRobotGame(),
      ),
      GoRoute(
        path: kWinScreen,
        builder: (context, state) {
          final finishedLevel = state.extra as int? ?? 1;
          return WinScreen(finishedLevel: finishedLevel);
        },
      ),
    ],
  );
}

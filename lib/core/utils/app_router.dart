import 'package:codekids/features/auth/presentation/views/sign_up_steps.dart';
import 'package:codekids/features/games/presentation/views/games_view.dart';
import 'package:codekids/features/home/presentation/views/bottom_nav_bar.dart';
import 'package:codekids/features/home/presentation/views/home_view.dart';
import 'package:codekids/features/notification/presentation/views/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/widgets/sign_in_view.dart';
import '../../features/games/presentation/views/quiz_game.dart';
import '../../features/games/presentation/views/help_robot_game.dart';
import '../../features/games/presentation/views/sorting_game.dart';
import '../../features/games/presentation/views/widgets/start_help_robot_game.dart';
import '../../features/games/presentation/views/widgets/win_screen.dart';
import '../../features/introduction/presentation/views/introduction_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../test.dart';

abstract class AppRouter {
  static const kIntroductionView = '/IntroductionView';
  static const kSignUpSteps = '/SignUpSteps';
  static const kSignInView = '/SignInView';
  static const kBottomNavBar = '/BottomNavBar';
  static const kNotifications = '/Notifications';
  static const kSortingGame = '/SortingGame';
  static const kQuizGame = '/QuizGame';
  static const kHelpRobotGame = '/HelpRobotGame';
  static const kWinScreen = '/WinScreen';

  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => SplashView(),
    ),
    GoRoute(
      path: kIntroductionView,
      builder: (BuildContext context, GoRouterState state) =>
          const IntroductionView(),
    ),
    GoRoute(
      path: kSignInView,
      builder: (BuildContext context, GoRouterState state) =>
          SignInView(),
    ),
    GoRoute(
      path: kSignUpSteps,
      builder: (BuildContext context, GoRouterState state) => const SignUpSteps(
        totalSteps: 8,
      ),
    ),
    GoRoute(
      path: kBottomNavBar,
      builder: (BuildContext context, GoRouterState state) => BottomNavBar(),
    ),
    GoRoute(
      path: kNotifications,
      builder: (BuildContext context, GoRouterState state) =>
          NotificationView(),
    ),
    GoRoute(
      path: kSortingGame,
      builder: (BuildContext context, GoRouterState state) => SortingGame(),
    ),
    GoRoute(
      path: kQuizGame,
      builder: (BuildContext context, GoRouterState state) => QuizGame(),
    ),
    GoRoute(
      path: kHelpRobotGame,
      builder: (BuildContext context, GoRouterState state) => HelpRobotGame(),
    ),
    GoRoute(
      path: kWinScreen,
      builder: (BuildContext context, GoRouterState state) => WinScreen(nextLevel: 2,),
    ),
  ]);
}

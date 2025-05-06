import 'package:codekids/features/auth/presentation/views/sign_up_steps.dart';
import 'package:codekids/features/home/presentation/views/bottom_nav_bar.dart';
import 'package:codekids/features/home/presentation/views/home_view.dart';
import 'package:codekids/features/notification/presentation/views/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/games/presentation/views/sorting_game.dart';
import '../../features/introduction/presentation/views/introduction_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../test.dart';

abstract class AppRouter {
  static const kIntroductionView = '/IntroductionView';
  static const kSignUpSteps = '/SignUpSteps';
  static const kBottomNavBar = '/BottomNavBar';
  static const kNotifications = '/Notifications';
  static const kSortingGame = '/SortingGame';

  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
           SplashView(),
    ),
    GoRoute(
      path: kIntroductionView,
      builder: (BuildContext context, GoRouterState state) =>
          const IntroductionView(),
    ),
    GoRoute(
      path: kSignUpSteps,
      builder: (BuildContext context, GoRouterState state) =>
          const SignUpSteps(totalSteps: 8,),
    ),
    GoRoute(
      path: kBottomNavBar,
      builder: (BuildContext context, GoRouterState state) => BottomNavBar(),
    ),
    GoRoute(
      path: kNotifications,
      builder: (BuildContext context, GoRouterState state) => NotificationView(),
    ),
    GoRoute(
      path: kSortingGame,
      builder: (BuildContext context, GoRouterState state) => SortingGame(),
    ),
  ]);
}

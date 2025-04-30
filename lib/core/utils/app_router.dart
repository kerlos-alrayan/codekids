import 'package:codekids/features/auth/presentation/views/sign_up_steps.dart';
import 'package:codekids/features/home/presentation/views/bottom_nav_bar.dart';
import 'package:codekids/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/introduction/presentation/views/introduction_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kIntroductionView = '/IntroductionView';
  static const kHomeView = '/HomeView';

  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          SignUpSteps(totalSteps: 4),
    ),
    GoRoute(
      path: kIntroductionView,
      builder: (BuildContext context, GoRouterState state) =>
          const IntroductionView(),
    ),
    GoRoute(
      path: kHomeView,
      builder: (BuildContext context, GoRouterState state) => const HomeView(),
    ),
  ]);
}

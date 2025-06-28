import 'package:codekids/core/utils/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../introduction/data/models/auth_viewmodel.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(milliseconds: 5640));

    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;

    if (!auth.isInitialized) {
      await auth.init();
    }

    print("Check from Splash:");
    print("Name: ${auth.name}");
    print("Gender: ${auth.gender}");
    print("Code: ${auth.loginCode}");

    if (!mounted) return;

    if (user != null && auth.name.isNotEmpty && auth.loginCode.isNotEmpty) {
      GoRouter.of(context).go(AppRouter.kBottomNavBar);
    } else {
      GoRouter.of(context).go(AppRouter.kAuthChoiceView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash/animation_logo.json',
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
    );
  }
}

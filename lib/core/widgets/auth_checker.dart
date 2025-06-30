import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_router.dart';
import '../../features/child_auth/data/models/auth_viewmodel.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final firebaseUser = FirebaseAuth.instance.currentUser;

    // لو لسه البيانات ما اتحملت من SharedPreferences
    if (!authViewModel.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ✅ بيانات موجودة
    if (firebaseUser != null && authViewModel.name.isNotEmpty) {
      Future.microtask(() => context.go(AppRouter.kBottomNavBar));
    } else {
      Future.microtask(() => context.go(AppRouter.kChildAuthView));
    }

    // شاشة مؤقتة أثناء التوجيه
    return const Scaffold(
      body: Center(child: Text("Checking authentication...")),
    );
  }
}

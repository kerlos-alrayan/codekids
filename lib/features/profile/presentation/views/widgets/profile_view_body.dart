import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codekids/core/utils/app_router.dart';
import 'package:codekids/core/utils/assets.dart';
import 'package:codekids/features/child_auth/data/models/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  void _logout(BuildContext context) async {
    final auth = context.read<AuthViewModel>();

    await auth.clearData();
    await FirebaseAuth.instance.signOut();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).go(AppRouter.kSignInViewKids);
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    final String name = auth.name ?? "Child";
    final String gender = auth.gender ?? "Boy";
    final sortingGameLevel = auth.levels['sortingGame'] ?? 1;
    final int helpRobotLevel = auth.levels['helpRobotGame'] ?? 1;


    final String avatarAsset =
        gender == "Girl" ? AssetsData.girl : AssetsData.boy;
    final String avatarLottie = gender == "Girl"
        ? 'assets/images/profile/lottie_girle.json'
        : 'assets/images/profile/Animation - 1750519452057.json';

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔵 Cover & Profile Image
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/profile/profile_cover.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: -120,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: Lottie.asset(
                        avatarLottie,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 65),

            // 🧒 Dynamic Name
            // 🧒 Dynamic Name + Code
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Code: ${auth.loginCode}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 40),

            // 🪙 sortingGame
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF8E52DC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🤖 Help the Robot: $helpRobotLevel',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF8E52DC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🪙 Sorting Game Level: $sortingGameLevel',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔴 Log Out Button
            TextButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Log Out',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

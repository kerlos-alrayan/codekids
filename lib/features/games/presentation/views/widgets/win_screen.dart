import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../help_robot_game.dart';

class WinScreen extends StatelessWidget {
  final int nextLevel;
  const WinScreen({super.key, required this.nextLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🎉 You did it!",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "You helped the robot reach the goal!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 40),
              Icon(Icons.star, size: 150,color: Colors.yellow,),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kHelpRobotGame, extra: nextLevel);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Next Level ➡️",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

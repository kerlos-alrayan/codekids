import 'package:flutter/material.dart';
import '../help_robot_game.dart';

class StartHelpRobotGame extends StatelessWidget {
  const StartHelpRobotGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🤖 Code Robot',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Help the robot reach the ⭐️',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/games/help_robot/start_robot.png', // ضع صورة روبوت طفولية هنا
              height: 150,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HelpRobotGame(),
                  ),
                );
              },
              child: const Text(
                'Start Game',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

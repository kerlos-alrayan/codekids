import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';

class WinScreen extends StatelessWidget {
  final int finishedLevel;
  WinScreen({super.key, required this.finishedLevel});

  final List<String> codeWords = [
    "Every", "program", "needs", "logic", "to",
    "solve", "real", "world", "problems", "."
  ];

  @override
  Widget build(BuildContext context) {
    final String codeSentence = finishedLevel <= codeWords.length
        ? codeWords.sublist(0, finishedLevel).join(" ")
        : codeWords.join(" ");

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // خلفية صفراء فاتحة
      body: Stack(
        children: [
          // 🎈 بالونات
          Positioned(top: 60, left: 30, child: _balloon(Colors.red)),
          Positioned(top: 100, right: 30, child: _balloon(Colors.blue)),
          Positioned(bottom: 100, left: 50, child: _balloon(Colors.purple)),
          Positioned(bottom: 60, right: 50, child: _balloon(Colors.green)),

          // 🧒🏽 محتوى الشاشة
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🏆 عنوان
                  const Text(
                    "🏆 Awesome!",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "You helped the robot!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 📘 الجملة البرمجية
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blueAccent, width: 3),
                    ),
                    child: Text(
                      finishedLevel < codeWords.length
                          ? '🧠 Code So Far:\n"$codeSentence"'
                          : '🎯 Final Code:\n"$codeSentence"',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 🎮 زر المستوى التالي
                  ElevatedButton.icon(
                    onPressed: () {
                      final int nextLevel =
                      finishedLevel >= 10 ? 1 : finishedLevel + 1;
                      GoRouter.of(context).pushReplacement(
                        AppRouter.kHelpRobotGame,
                        extra: nextLevel,
                      );
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Next Level",style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🎈 ويدجت بالونة بسيطة
  Widget _balloon(Color color) {
    return Icon(
      Icons.emoji_emotions,
      color: color,
      size: 40,
    );
  }
}

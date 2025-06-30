import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codekids/features/games/presentation/views/widgets/win_screen.dart';
import 'package:flutter/material.dart';
import 'package:codekids/features/games/presentation/views/widgets/control_panel.dart';
import 'package:codekids/features/games/presentation/views/widgets/custom_grid_widget.dart';
import 'package:codekids/features/games/presentation/views/widgets/game_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_router.dart';
import '../../../child_auth/data/models/auth_viewmodel.dart';

class HelpRobotGame extends StatefulWidget {
  final int level;

  const HelpRobotGame({super.key, this.level = 1});

  @override
  State<HelpRobotGame> createState() => _HelpRobotGameState();
}

class _HelpRobotGameState extends State<HelpRobotGame> {
  final GameController controller = GameController();
  int currentLevel = 1;
  Future<void> loadLevelFromFirestore(int level) async {
    final doc = await FirebaseFirestore.instance
        .collection('robot_levels')
        .where('level', isEqualTo: level)
        .limit(1)
        .get();

    if (doc.docs.isNotEmpty) {
      final data = doc.docs.first.data();
      final startX = data['robotX'] ?? 0;
      final startY = data['robotY'] ?? 0;
      final goal = data['goal'] ?? {'x': 3, 'y': 3};
      final List<dynamic> rawObstacles = data['obstacles'] ?? [];

      controller.setFromData(
        startX: startX,
        startY: startY,
        goalX: goal['x'],
        goalY: goal['y'],
        obstacles: rawObstacles.map((e) => [e['x'] as int, e['y'] as int]).toList(),
      );

      setState(() {});
    } else {
      // ✅ مفيش مستوى بالرقم ده؟ نرجع لأول مستوى
      loadLevelFromFirestore(1);
    }
  }

  void updateUI() => setState(() {});

  void _showMessageDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.lightBlue[50],
        title: Text(title, style: const TextStyle(fontSize: 24)),
        content: Text(content, style: const TextStyle(fontSize: 20)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.reset();
              setState(() {});
            },
            child: const Text("Play Again", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final auth = Provider.of<AuthViewModel>(context, listen: false);
      currentLevel = auth.levels['helpRobotGame'] ?? 1;
      loadLevelFromFirestore(currentLevel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/games/help_robot/help_the_robot_bg.png'),fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                '🤖 Help The Robot!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blueGrey, width: 3),
                  ),
                  child: GridWidget(
                    robotX: controller.robotX,
                    robotY: controller.robotY,
                    obstacles: controller.obstacles,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ControlPanel(
                onExecuteCommand: (command) async {
                  await controller.executeCommand(
                    command,
                    () => setState(() {}),
                    (msg) => _showMessageDialog("Oops!", msg),
                  );
                  if (controller.robotX == controller.goalX && controller.robotY == controller.goalY) {
                    final auth = Provider.of<AuthViewModel>(context, listen: false);
          
                    // 🟢 المتغير دا يمثل الليفل الحالي اللي خلصه اللاعب
                    final finishedLevel = currentLevel;
          
                    // ⬅️ بعد كده هنحسب الليفل الجاي
                    int nextLevel = currentLevel + 1;
                    if (nextLevel > 10) {
                      nextLevel = 1;
                    }
          
                    // 🟢 حفظ المستوى الجديد
                    await auth.updateGameLevel('helpRobotGame', nextLevel);
                    currentLevel = nextLevel;
          
                    // ✅ التنقل لشاشة الفوز، مع إرسال المستوى المنتهي فعليًا
                    GoRouter.of(context).pushReplacement(AppRouter.kWinScreen, extra: finishedLevel);
                  }
          
          
          
          
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:codekids/features/games/presentation/views/widgets/win_screen.dart';
import 'package:flutter/material.dart';
import 'package:codekids/features/games/presentation/views/widgets/control_panel.dart';
import 'package:codekids/features/games/presentation/views/widgets/custom_grid_widget.dart';
import 'package:codekids/features/games/presentation/views/widgets/game_controller.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';

class HelpRobotGame extends StatefulWidget {
  final int level;
  const HelpRobotGame({super.key, this.level = 1});

  @override
  State<HelpRobotGame> createState() => _HelpRobotGameState();
}

class _HelpRobotGameState extends State<HelpRobotGame> {
  final GameController controller = GameController();

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
    controller.setLevel(widget.level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text(
          '🤖 Help The Robot!',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            '🚀 Move the robot to the star!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
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

              if (controller.robotX == 3 && controller.robotY == 3) {
                GoRouter.of(context).push(AppRouter.kWinScreen, extra: widget.level + 1);
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

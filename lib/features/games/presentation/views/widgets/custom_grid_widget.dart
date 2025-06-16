import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  final int robotX;
  final int robotY;
  final List<List<int>> obstacles;

  const GridWidget({
    super.key,
    required this.robotX,
    required this.robotY,
    required this.obstacles,
  });

  bool isObstacle(int x, int y) {
    return obstacles.any((pos) => pos[0] == x && pos[1] == y);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (y) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (x) {
            final isRobot = robotX == x && robotY == y;
            final isGoal = x == 3 && y == 3;
            final isBlock = isObstacle(x, y);

            return Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isGoal
                    ? Colors.yellow[300]
                    : isBlock
                    ? Colors.red[200]
                    : Colors.grey[200],
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: isRobot
                    ? const Text('🤖', style: TextStyle(fontSize: 28))
                    : isBlock
                    ? const Text('🧱', style: TextStyle(fontSize: 24))
                    : null,
              ),
            );
          }),
        );
      }),
    );
  }
}

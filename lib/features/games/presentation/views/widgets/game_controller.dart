import 'package:cloud_firestore/cloud_firestore.dart';

class GameController {
  int robotX = 0;
  int robotY = 0;
  int goalX = 3;
  int goalY = 3;

  List<List<int>> obstacles = [];

  bool isObstacle(int x, int y) {
    return obstacles.any((pos) => pos[0] == x && pos[1] == y);
  }

  Future<void> executeCommand(
      String command,
      Function updateUI,
      Function(String) showAlert,
      ) async {
    int newX = robotX;
    int newY = robotY;

    if (command == 'right' && robotX < 3) {
      newX++;
    } else if (command == 'left' && robotX > 0) {
      newX--;
    } else if (command == 'down' && robotY < 3) {
      newY++;
    } else if (command == 'up' && robotY > 0) {
      newY--;
    }

    if (isObstacle(newX, newY)) {
      showAlert("Oops! There's an obstacle!");
      return;
    }

    robotX = newX;
    robotY = newY;
    updateUI();
  }

  Future<void> setLevel(int level) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('robot_levels')
          .where('level', isEqualTo: level)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();

        robotX = data['robotX'] ?? 0;
        robotY = data['robotY'] ?? 0;

        final goal = List<int>.from(data['goal'] ?? [3, 3]);
        goalX = goal[0];
        goalY = goal[1];

        final rawObstacles = data['obstacles'] ?? [];
        obstacles = List<List<int>>.from(
          rawObstacles.map((e) => List<int>.from(e)),
        );
      } else {
        robotX = 0;
        robotY = 0;
        goalX = 3;
        goalY = 3;
        obstacles = [];
      }
    } catch (e) {
      print("Error loading level: $e");
      robotX = 0;
      robotY = 0;
      goalX = 3;
      goalY = 3;
      obstacles = [];
    }
  }

  // ✅ هنا الميثود المطلوبة
  void setFromData({
    required int startX,
    required int startY,
    required int goalX,
    required int goalY,
    required List<List<int>> obstacles,
  }) {
    robotX = startX;
    robotY = startY;
    this.goalX = goalX;
    this.goalY = goalY;
    this.obstacles = obstacles;
  }

  void reset() {
    robotX = 0;
    robotY = 0;
  }
}

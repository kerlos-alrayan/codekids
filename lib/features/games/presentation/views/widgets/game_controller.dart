class GameController {
  int robotX = 0;
  int robotY = 0;

  // نلغي final علشان نقدر نغيرها حسب المستوى
  List<List<int>> obstacles = [
    [1, 0],
    [2, 2],
  ];

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

  void setLevel(int level) {
    robotX = 0;
    robotY = 0;

    // تختلف العقبات حسب المستوى
    if (level == 1) {
      obstacles = [
        [1, 0],
        [2, 2],
      ];
    } else if (level == 2) {
      obstacles = [
        [0, 1],
        [1, 2],
        [3, 1],
      ];
    } else if (level == 3) {
      obstacles = [
        [1, 1],
        [2, 0],
        [2, 2],
        [3, 1],
      ];
    } else {
      obstacles = [];
    }
  }

  void reset() {
    robotX = 0;
    robotY = 0;
  }
}

import 'package:flutter/material.dart';

import '../../data/quiz_game/quiz_game_data.dart';

class QuizGame extends StatefulWidget {
  const QuizGame({super.key});

  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  int currentIndex = 0;
  int? selectedAnswerIndex;
  bool answered = false;

  void nextQuestion() {
    setState(() {
      currentIndex++;
      selectedAnswerIndex = null;
      answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Game for Kids')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q${currentIndex + 1}: ${question.questionText}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(question.options.length, (index) {
              final isCorrect = question.correctAnswerIndex == index;
              final isSelected = selectedAnswerIndex == index;

              Color? color;
              if (answered) {
                if (isSelected) {
                  color = isCorrect ? Colors.green : Colors.red;
                } else if (isCorrect) {
                  color = Colors.green;
                }
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: answered
                      ? null
                      : () {
                    setState(() {
                      selectedAnswerIndex = index;
                      answered = true;
                    });
                  },
                  child: Text(question.options[index]),
                ),
              );
            }),
            const Spacer(),
            if (answered)
              ElevatedButton(
                onPressed: currentIndex < questions.length - 1
                    ? nextQuestion
                    : () {
                  // You can show results or restart here
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Quiz Finished!'),
                      content: const Text('Great job 🎉'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              currentIndex = 0;
                              selectedAnswerIndex = null;
                              answered = false;
                            });
                          },
                          child: const Text('Restart'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  currentIndex < questions.length - 1 ? 'Next' : 'Finish',
                ),
              ),
          ],
        ),
      ),
    );
  }
}

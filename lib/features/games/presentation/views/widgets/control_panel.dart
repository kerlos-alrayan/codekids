import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  final Function(String) onExecuteCommand;

  const ControlPanel({
    super.key,
    required this.onExecuteCommand,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // زر UP
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton('⬆️', 'Up', 'up'),
          ],
        ),
        const SizedBox(height: 12),

        // أزرار Left و Right
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton('⬅️', 'Left', 'left'),
            const SizedBox(width: 100),
            _buildButton('➡️', 'Right', 'right'),
          ],
        ),
        const SizedBox(height: 12),

        // زر DOWN
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton('⬇️', 'Down', 'down'),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String emoji, String label, String direction) {
    return ElevatedButton(
      onPressed: () => onExecuteCommand(direction),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontSize: 20),
      ),
      child: Text('$emoji $label'),
    );
  }
}

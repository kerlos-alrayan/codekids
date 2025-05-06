import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/styles.dart';

class CustomIconGameInfo extends StatelessWidget {
  final List infoIcon;
  final VoidCallback onPlay;
  const CustomIconGameInfo({super.key, required this.infoIcon, required this.onPlay});

  void _showGameInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('About the Game 🎮'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (infoIcon.isNotEmpty && infoIcon.length >= 2)
              Row(
                children: [
                  Lottie.asset(infoIcon[0], height: 100),
                  const SizedBox(width: 20),
                  Lottie.asset(infoIcon[1], height: 100),
                ],
              ),
            const SizedBox(height: 12),
            if (infoIcon.length > 2)
              Text(
                infoIcon[2],
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: onPlay,
            child: Text('Let\'s Go!', style: Styles.textStyle16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: () => _showGameInfoDialog(context),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black26),
          ),
          child: const Icon(
            Icons.info_outline,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}


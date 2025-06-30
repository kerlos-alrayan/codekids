import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/auth_viewmodel.dart';

class LoginCodeSetupPage extends StatelessWidget {
  const LoginCodeSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(height: h * 0.05),
          const Text(
            '🔐 Choose a Magic Code!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'This will help you log in next time. \nMake it fun and easy to remember!',
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: h * 0.05),
          Container(
            width: w * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.purpleAccent, width: 2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.purpleAccent.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => authViewModel.setLoginCode(value),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your special code ✨',
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: h * 0.04),
          const Text(
            '🧠 Tip: Don’t forget it!',
            style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
          ),
        ],
      ),
    );
  }
}

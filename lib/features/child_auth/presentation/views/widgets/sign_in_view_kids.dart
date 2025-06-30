import 'package:codekids/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/assets.dart';
import '../../../data/models/auth_viewmodel.dart';

class SignInViewKids extends StatefulWidget {
  const SignInViewKids({super.key});

  @override
  State<SignInViewKids> createState() => _SignInViewKidsState();
}

class _SignInViewKidsState extends State<SignInViewKids> {
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;

  void _signIn() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎈 Please enter your magic code!'),
          backgroundColor: Colors.deepOrangeAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final auth = context.read<AuthViewModel>();
    final success = await auth.signInWithCode(context, code);

    setState(() => _isLoading = false);

    if (success) {
      GoRouter.of(context).pushReplacement(AppRouter.kBottomNavBar); // أو AppRouter.kBottomNavBar
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDEBEB), Color(0xFFD0F0FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                AssetsData.appLogo,
                height: 120,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '🎉 Welcome Back, Star!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '✨ Enter your magic code to start learning!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.number,
              controller: _codeController,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '🔐 Enter your code',
                hintStyle: const TextStyle(fontSize: 16),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 180,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Colors.purpleAccent,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  '✨ Sign In',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kChildAuthView);
                  },
                  child: const Text(
                    "Create one!",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

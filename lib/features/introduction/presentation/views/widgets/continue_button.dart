import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../manger/introduction_cubit/introduction_cubit.dart';

class ContinueButton extends StatelessWidget {
  final int state;
  const ContinueButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 150,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 8,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.deepPurpleAccent.withOpacity(0.6),
          ),
          onPressed: () {
            if (state == 3) {
              GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
            } else {
              context.read<IntroCubit>().nextStep();
            }
          },
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.deepPurple],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

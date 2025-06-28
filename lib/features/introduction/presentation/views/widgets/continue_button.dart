import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../data/models/auth_viewmodel.dart';
import '../../manger/switch_page_cubit/switch_page_cubit.dart';

class ContinueButton extends StatefulWidget {
  final int state;
  const ContinueButton({super.key, required this.state});

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 180,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.transparent,
          ),
          onPressed: isLoading
              ? null
              : () async {
            final auth = context.read<AuthViewModel>();
            print('Name: ${auth.name}, Gender: ${auth.gender}, Birth: ${auth.birthDate}, Code: ${auth.loginCode}');

            if (widget.state == 0) {
              // تحقق من البيانات الأساسية
              if (auth.name.isEmpty || auth.gender.isEmpty || auth.birthDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields before continuing!'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              context.read<IntroCubit>().nextStep();
            } else if (widget.state == 1) {
              // تحقق من كود الدخول
              if (auth.loginCode.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please enter your magic code ✨"),
                    backgroundColor: Colors.orange,
                  ),
                );
                return;
              }

              setState(() => isLoading = true);

              await auth.submit(
                context,
                onSuccess: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kBottomNavBar);
                },
              );

              setState(() => isLoading = false);
            }
          },
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFD5EB3), Color(0xFF8C52FF)],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              alignment: Alignment.center,
              child: isLoading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Text(
                widget.state == 1 ? 'Start Fun!' : 'Continue',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

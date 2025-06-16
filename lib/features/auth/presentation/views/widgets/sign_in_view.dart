import 'package:codekids/core/utils/styles.dart';
import 'package:codekids/features/auth/presentation/views/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/loginControllers.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final bool isPasswordObscure = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final LoginControllers loginControllers = LoginControllers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/app_icon/icon_app.png')),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome to CodeKids',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 28),
                    // Email
                    CustomTextFormField(
                      borderColor: Color(0xffEBF0FF),
                      isPassword: false,
                      controller: emailController,
                      hintText: "Your Email",
                      labelText: "Your Email",
                      prefixIcon: Icons.mail_outline,
                      validator: (value) {
                        if (!loginControllers.isValidEmail(value!)) {
                          return "Email invalid";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 8),
                    // Password

                    CustomTextFormField(
                      controller: passwordController,
                      hintText: 'Password',
                      labelText: 'Password',
                      validator: (pass) {
                        if (pass == null || pass.isEmpty) {
                          return 'Your Password cannot be empty';
                        } else if (pass.length <= 7) {
                          return 'Your Password is too weak';
                        }
                        return null;
                      },
                      prefixIcon: Icons.lock_outline_sharp,
                      isPassword: true,
                      suffixIcon: IconButton(
                          icon: Icon(
                            true ? Icons.visibility_off : Icons.visibility,
                            color: Color(0xff9098B1),
                          ),
                          onPressed: () {}),
                      textInputAction: TextInputAction.done,
                    ),

                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: const Size(343, 57)),
                        onPressed: () => GoRouter.of(context).push(AppRouter.kBottomNavBar),
                        child: Text(
                          'Sign In',
                          style:
                              Styles.textStyle16.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Forget Password",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xff40BFFF),
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                    _registerSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _registerSection(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 12)),
        GestureDetector(
          onTap: () => GoRouter.of(context).push(AppRouter.kSignUpSteps),
          child: const Text('Register',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xff40BFFF))),
        ),
      ],
    ),
  );
}

import 'package:codekids/features/child_auth/presentation/views/widgets/continue_button.dart';
import 'package:codekids/features/child_auth/presentation/views/widgets/login_code_setup_page.dart';
import 'package:codekids/features/child_auth/presentation/views/widgets/name_and_gender_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/switch_page_cubit/switch_page_cubit.dart';

class ChildAuthViewBody extends StatelessWidget {
  const ChildAuthViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SwitchPageCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB3E5FC), Color(0xFFE1BEE7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: BlocBuilder<SwitchPageCubit, int>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: IndexedStack(
                          index: state,
                          children: [
                            NameAndGenderPage(),
                            LoginCodeSetupPage(),
                            // BirthdayPage(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ContinueButton(state: state),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

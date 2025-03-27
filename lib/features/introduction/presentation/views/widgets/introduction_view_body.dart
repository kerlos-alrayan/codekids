import 'package:codekids/core/utils/app_router.dart';
import 'package:codekids/features/introduction/presentation/views/widgets/continue_button.dart';
import 'package:codekids/features/introduction/presentation/views/widgets/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../manger/introduction_cubit/introduction_cubit.dart';

class IntroductionViewBody extends StatelessWidget {
  const IntroductionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IntroCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<IntroCubit, int>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(22),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    IndexedStack(
                      index: state,
                      children: const [
                        IntroPage(),
                      ],
                    ),
                    ContinueButton(
                      state: state,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

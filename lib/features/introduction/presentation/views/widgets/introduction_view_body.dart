import 'package:codekids/features/introduction/presentation/views/widgets/birthday_page.dart';
import 'package:codekids/features/introduction/presentation/views/widgets/continue_button.dart';
import 'package:codekids/features/introduction/presentation/views/widgets/intro_page.dart';
import 'package:codekids/features/introduction/presentation/views/widgets/name_and_gender_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/switch_page_cubit/switch_page_cubit.dart';


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
                        NameAndGenderPage(),
                        //BirthdayPage(),
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

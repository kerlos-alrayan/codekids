import 'package:codekids/features/introduction/presentation/views/widgets/child_input_name.dart';
import 'package:codekids/features/introduction/presentation/views/widgets/gender_choice.dart';
import 'package:codekids/features/introduction/presentation/views/widgets/select_birthday.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';

class NameAndGenderPage extends StatelessWidget {
  const NameAndGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        spacing: h * .04,
        children: [
          const Text(
            'Let\'s Get Started',
            style: Styles.textStyle18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              textAlign: TextAlign.center,
              'Help us personalize your child\'s learning experience',
              style: Styles.textStyle14.copyWith(height: 2),
            ),
          ),
          const Text(
            'Select your gender',
            style: Styles.textStyle18,
          ),
          GenderChoice(),
          ChildInputName(),
          SelectBirthDay(),
        ],
      ),
    );
  }
}


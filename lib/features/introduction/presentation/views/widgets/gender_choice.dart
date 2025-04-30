import 'package:codekids/features/introduction/presentation/views/widgets/custom_gender_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manger/selector_gender_cubit/selector_gender_cubit.dart';

class GenderChoice extends StatelessWidget {
  const GenderChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectorGenderCubit(),
      child: BlocBuilder<SelectorGenderCubit, String>(
        builder: (context, selectedGender) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomGenderContainer(
                  gender: 'Boy',
                  image: 'assets/images/gender/boy.png',
                  isSelected: selectedGender == 'Boy',
                  onTap: () {
                    context.read<SelectorGenderCubit>().selectGender('Boy');
                  },
                ),
                CustomGenderContainer(
                  gender: 'Girl',
                  image: 'assets/images/gender/girl.png',
                  isSelected: selectedGender == 'Girl',
                  onTap: () {
                    context.read<SelectorGenderCubit>().selectGender('Girl');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:codekids/features/introduction/presentation/views/widgets/custom_gender_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/auth_viewmodel.dart';

class GenderChoice extends StatelessWidget {
  const GenderChoice({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final selectedGender = authViewModel.gender;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Text(
            '🧒👧 Choose your gender:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomGenderContainer(
                gender: 'Boy',
                image: 'assets/images/gender/boy.png',
                isSelected: selectedGender == 'Boy',
                onTap: () => authViewModel.setGender('Boy'),
              ),
              CustomGenderContainer(
                gender: 'Girl',
                image: 'assets/images/gender/girl.png',
                isSelected: selectedGender == 'Girl',
                onTap: () => authViewModel.setGender('Girl'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

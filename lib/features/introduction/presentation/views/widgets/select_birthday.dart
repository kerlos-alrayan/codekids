import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/styles.dart';

import 'package:provider/provider.dart';

import '../../../data/models/auth_viewmodel.dart';

class SelectBirthDay extends StatelessWidget {
  const SelectBirthDay({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final selectedDate = authViewModel.birthDate;

    return Column(
      children: [
        TextButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2010, 1, 1),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );

            if (pickedDate != null) {
              authViewModel.setBirthDate(pickedDate);
            }
          },
          child: const Text(
            'Select your BirthDay',
            style: Styles.textStyle18,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          selectedDate != null
              ? "Birthdate: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"
              : "",
          style: Styles.textStyle14,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/styles.dart';
import '../../manger/select_birthday_cubit/select_birthday_cubit.dart';

class SelectBirthDay extends StatelessWidget {
  const SelectBirthDay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BirthDateCubit(),
      child: Builder(
        builder: (context) {
          final birthDateCubit = context.watch<BirthDateCubit>();

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
                    birthDateCubit.selectDate(pickedDate);
                  }
                },
                child: const Text(
                  'Select your BirthDay',
                  style: Styles.textStyle18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                birthDateCubit.state != null
                    ? "Birthdate: ${DateFormat('yyyy-MM-dd').format(birthDateCubit.state!)}"
                    : "",
                style: Styles.textStyle14,
              ),

            ],
          );
        },
      ),
    );
  }
}

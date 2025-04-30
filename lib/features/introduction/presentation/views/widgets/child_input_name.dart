import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';

class ChildInputName extends StatelessWidget {
  const ChildInputName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        const Text(
          'What is your Name?',
          style: Styles.textStyle18,
        ),
        TextField(
          decoration: InputDecoration(
              hintText: 'Your Name',
              hintStyle: Styles.textStyle14.copyWith(color: Colors.grey)),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/styles.dart';

import 'package:provider/provider.dart';

import '../../../data/models/auth_viewmodel.dart';

class ChildInputName extends StatelessWidget {
  const ChildInputName({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return Column(
      spacing: 20,
      children: [
        GestureDetector(
          onTap: () => GoRouter.of(context).push(AppRouter.kSignInView),
          child: Text(
            'Or you are a teacher?🤔',
            style: Styles.textStyle18.copyWith(color: Colors.purple),
          ),
        ),
        TextField(
          onChanged: (value) => context.read<AuthViewModel>().setName(value),
          decoration: InputDecoration(
            hintText: 'Your Name',
            hintStyle: Styles.textStyle14.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

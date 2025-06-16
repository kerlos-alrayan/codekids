import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/styles.dart';

class ChildInputName extends StatelessWidget {
  const ChildInputName({super.key});

  @override
  Widget build(BuildContext context) {
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
          decoration: InputDecoration(
              hintText: 'Your Name',
              hintStyle: Styles.textStyle14.copyWith(color: Colors.grey)),
        ),
      ],
    );
  }
}

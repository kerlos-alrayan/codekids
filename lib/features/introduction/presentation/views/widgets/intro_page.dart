import 'package:flutter/material.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/styles.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AssetsData.programmerBoy),
        SizedBox(
          height: h * .04,
        ),
        const Text(
          'Welcome to CodeKids',
          style: Styles.textStyle18,
        ),
        SizedBox(
          height: h * .05,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child:  Text(
            textAlign: TextAlign.center,
            'Let’s make Code Kids special for you!Tell us a little about yourself to start learning and having fun!',
            style: Styles.textStyle14.copyWith(height: 2),
          ),
        ),
        SizedBox(
          height: h * .12,
        ),
      ],
    );
  }
}

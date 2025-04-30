import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';

class CustomGenderContainer extends StatelessWidget {
  const CustomGenderContainer(
      {super.key,
      required this.gender,
      required this.image,
      required this.isSelected,
      required this.onTap});
  final String gender;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w * .35,
        height: h * .2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 4,
            color: isSelected ? Colors.purple : Color(0xffDDDDDD),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Text(
              gender,
              style: Styles.textStyle20,
            ),
            Expanded(child: Image.asset(image))
          ],
        ),
      ),
    );
  }
}

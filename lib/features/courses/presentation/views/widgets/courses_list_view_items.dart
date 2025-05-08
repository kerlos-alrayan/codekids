import 'package:codekids/core/utils/assets.dart';
import 'package:codekids/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CoursesListViewItems extends StatelessWidget {
  const CoursesListViewItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: Colors.black26,
          )),
      child: Row(
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.zero,
              bottomRight: Radius.zero,
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AssetsData.courseCard,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutter',
                style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '12 videos',
                style: Styles.textStyle14,
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xffFF7401),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  'Get Course',
                  style: Styles.textStyle18.copyWith(color: Colors.white),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

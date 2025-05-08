import 'package:codekids/core/utils/styles.dart';
import 'package:codekids/features/courses/presentation/views/widgets/courses_list_view_items.dart';
import 'package:flutter/material.dart';

class CoursesViewBody extends StatelessWidget {
  const CoursesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            'Courses',
            style: Styles.textStyle30.copyWith(
              color: const Color(0xff211B46),
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Colors.black26,
                ),
                Shadow(
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  color: Color(0xffbbdefbff),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CoursesListViewItems(),
                  );
                }),
          )
        ],
      ),
    );
  }
}


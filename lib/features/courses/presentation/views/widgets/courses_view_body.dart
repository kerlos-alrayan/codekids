import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codekids/core/utils/styles.dart';
import 'package:codekids/features/courses/presentation/views/widgets/courses_list_view_items.dart';
import 'package:flutter/material.dart';

import '../../../data/models/courses_model.dart';

class CoursesViewBody extends StatelessWidget {
  const CoursesViewBody({super.key});

  Stream<List<CourseModel>> courseStream() {
    return FirebaseFirestore.instance.collection('courses').snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) {
          return CourseModel.fromFirestore(doc.data(), doc.id);
        }).toList();
      },
    );
  }


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

          Expanded(
            child: StreamBuilder<List<CourseModel>>(
              stream: courseStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final courses = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: CoursesListViewItems(course: courses[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


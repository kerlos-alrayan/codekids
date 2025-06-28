import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codekids/core/utils/styles.dart';
import 'package:codekids/features/home/presentation/views/widgets/course_card.dart';
import 'package:codekids/features/home/presentation/views/widgets/custom_carousel_slider.dart';
import 'package:codekids/features/home/presentation/views/widgets/language_categories.dart';
import 'package:codekids/features/home/presentation/views/widgets/search_and_notification_bar.dart';
import 'package:flutter/material.dart';

import '../../../../courses/data/models/courses_model.dart';
import '../../../../courses/presentation/views/widgets/courses_list_view_items.dart';


class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});
  Stream<List<CourseModel>> getLastThreeCoursesStream() {
    return FirebaseFirestore.instance
        .collection('courses')
        .orderBy('createdAt', descending: true)
        .limit(3)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CourseModel.fromFirestore(doc.data(), doc.id))
        .toList());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchAndNotificationBar(),
            SizedBox(height: 16),
            CustomCarouselSlider(),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore categories',
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10),

            CategoriesWidget(),
            SizedBox(height: 20),
          StreamBuilder<List<CourseModel>>(
            stream: getLastThreeCoursesStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final courses = snapshot.data!;
              if (courses.isEmpty) {
                return const Center(child: Text('No courses yet.'));
              }

              return CourseCard(courses: courses);
            },
          ),
          ],
        ),
      ),
    );
  }
}

import 'package:codekids/core/utils/styles.dart';
import 'package:codekids/features/home/presentation/views/widgets/course_card.dart';
import 'package:codekids/features/home/presentation/views/widgets/custom_carousel_slider.dart';
import 'package:codekids/features/home/presentation/views/widgets/language_categories.dart';
import 'package:codekids/features/home/presentation/views/widgets/search_and_notification_bar.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchAndNotificationBar(),
            SizedBox(height: 16),
            CustomCarouselSlider(),
            SizedBox(height: 20),
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
                  Text(
                    'See all',
                    style: Styles.textStyle14.copyWith(color: Colors.blue),
                  ),
                ],
              ),
            ),
            LanguageCategories(),
            SizedBox(height: 20),
            CourseCard(),
          ],
        ),
      ),
    );
  }
}

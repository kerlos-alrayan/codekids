import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      options: CarouselOptions(
        height: 170,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        enableInfiniteScroll: true,
        viewportFraction: 0.7, // تقلل العرض عشان يبان الفاصل
        padEnds: false, // عشان يبدأ من أول عنصر مش في النص
        scrollDirection: Axis.horizontal,
        reverse: false, // من اليمين لليسار
      ),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0), // 8+8 = 16 بين كل عنصر
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              color: Color(0xffA991D2),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(
                  'https://digitallearning.eletsonline.com/wp-content/uploads/2019/03/Online-courses.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

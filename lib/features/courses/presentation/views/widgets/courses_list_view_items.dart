import 'package:codekids/features/courses/presentation/views/widgets/course_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/courses_model.dart';

class CoursesListViewItems extends StatelessWidget {
  final CourseModel course;

  const CoursesListViewItems({super.key, required this.course});

  Future<void> joinCourse(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = await FirebaseFirestore.instance
        .collection('children')
        .doc(userId)
        .get();

    if (!userDoc.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not found in children collection')),
      );
      return;
    }

    final name = userDoc['name'] ?? 'No Name';
    final code = userDoc['loginCode'] ?? '0000';

    final enrolledRef = FirebaseFirestore.instance
        .collection('courses')
        .doc(course.id)
        .collection('enrolledUsers')
        .doc(userId);

    final exists = await enrolledRef.get();
    if (exists.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You already joined this course')),
      );
      return;
    }

    // 🔹 أضف الطفل إلى enrolledUsers في الكورس
    await enrolledRef.set({
      'name': name,
      'code': code,
      'joinedAt': FieldValue.serverTimestamp(),
    });

    // 🔹 أضف الطفل إلى students عشان الداشبورد يقرأه
    await FirebaseFirestore.instance.collection('students').doc(userId).set({
      'name': name,
      'code': code,
      'averageMark': 0.0,
      'teacherId': course.teacherId, // تأكد أن الكورس يحتوي على teacherId
      'joinedAt': FieldValue.serverTimestamp(),
    });
    await FirebaseFirestore.instance.collection('children').doc(userId).update({
      'teacherId': course.teacherId,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🎉 Successfully joined the course!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // صورة الكورس
              Image.network(
                course.imageUrl,
                fit: BoxFit.cover,
              ),

              // طبقة تغطية للتوضيح
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),

              // النصوص والزر
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // زر طفولي
                    GestureDetector(
                      onTap: () {
                        joinCourse(context).then((_) {
                          if (course.videoUrl != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CourseVideoScreen(
                                  videoUrl: course.videoUrl!,
                                  courseTitle: course.title,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("No video found for this course")),
                            );
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF8E2DE2),
                              Color(0xFF4A00E0)
                            ], // Purple gradient
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.school,
                                color: Colors.white,
                                size: 22), // طفولي أكتر من play
                            SizedBox(width: 8),
                            Text(
                              'Let\'s Go!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
                                    blurRadius: 3,
                                    color: Colors.black38,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

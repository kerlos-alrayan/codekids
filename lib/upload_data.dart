// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart'; // لو بتستخدم Flutter Web
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform, // لو عندك FirebaseOptions
//   );
//
//   await uploadCategoriesData();
//
//   runApp(const MyApp());
// }
//
// Future<void> uploadCategoriesData() async {
//   final firestore = FirebaseFirestore.instance;
//
//   final categories = [
//     {
//       "name": "Games",
//       "image": "https://cdn-icons-png.flaticon.com/128/2991/2991463.png"
//     },
//     {
//       "name": "Web",
//       "image": "https://cdn-icons-png.flaticon.com/128/2721/2721688.png"
//     },
//     {
//       "name": "AI",
//       "image": "https://cdn-icons-png.flaticon.com/128/8131/8131880.png"
//     },
//     {
//       "name": "Robotics",
//       "image": "https://cdn-icons-png.flaticon.com/128/3570/3570207.png"
//     },
//     {
//       "name": "Mobile",
//       "image": "https://cdn-icons-png.flaticon.com/128/3437/3437364.png"
//     },
//   ];
//
//   for (final category in categories) {
//     await firestore.collection('categories').add({
//       "name": category['name'],
//       "image": category['image'],
//     });
//     print('✅ Uploaded category: ${category['name']}');
//   }
//
//   print('🎉 All categories uploaded successfully');
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(child: Text('✅ Categories Uploaded')),
//       ),
//     );
//   }
// }
// void setupInitialFirestoreStructure() async {
//   final firestore = FirebaseFirestore.instance;
//
//   // 1️⃣ Create a sample teacher
//   await firestore.collection('teachers').doc('teacher_1').set({
//     'name': 'Kerlos AlRayan',
//     'email': 'kerlos@gmail.com',
//     'phone': '01283439201',
//     'qualification': 'CS',
//     'experienceYears': 3,
//     'hoursSpent': 0,
//     'lectionsLeft': 10,
//     'specialty': '',
//     'linkedIn': '',
//     'createdAt': FieldValue.serverTimestamp(),
//   });
//
//   // 2️⃣ Create a sample course
//   await firestore.collection('courses').doc('course_1').set({
//     'title': 'Flutter for Kids',
//     'imageUrl': 'https://example.com/image.png',
//     'videosCount': 12,
//     'teacherId': 'teacher_1',
//     'category': 'Programming',
//     'description': 'Beginner level course to learn Flutter',
//     'createdAt': FieldValue.serverTimestamp(),
//   });
//
//   // 2️⃣.1 Add enrolled user under course
//   await firestore
//       .collection('courses')
//       .doc('course_1')
//       .collection('enrolledUsers')
//       .doc('student_1')
//       .set({
//     'name': 'Youssef',
//     'code': '12345',
//     'joinedAt': FieldValue.serverTimestamp(),
//   });
//
//   // 3️⃣ Create a student
//   await firestore.collection('students').doc('student_1').set({
//     'name': 'Youssef',
//     'code': '12345',
//     'teacherId': 'teacher_1',
//     'averageMark': 6.5,
//   });
//
//   // 4️⃣ Create marks
//   await firestore.collection('marks').doc('student_1').set({
//     'math': 7,
//     'science': 5,
//     'flutter': 8,
//   });
//
//   // 5️⃣ Create homeworks
//   await firestore.collection('homeworks').doc('hw_1').set({
//     'teacherId': 'teacher_1',
//     'title': 'Lesson 1 Homework',
//     'status': 'done',
//     'studentId': 'student_1',
//   });
//
//   print("✅ Initial Firestore structure created successfully.");
// }
// void uploadRobotLevels() async {
//   final levels = [
//     {
//       "level": 1,
//       "robotX": 0,
//       "robotY": 0,
//       "obstacles": [],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 2,
//       "robotX": 0,
//       "robotY": 0,
//       "obstacles": [
//         {"x": 1, "y": 1}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 3,
//       "robotX": 0,
//       "robotY": 0,
//       "obstacles": [
//         {"x": 1, "y": 0},
//         {"x": 2, "y": 2}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 4,
//       "robotX": 0,
//       "robotY": 0,
//       "obstacles": [
//         {"x": 0, "y": 1},
//         {"x": 1, "y": 1},
//         {"x": 2, "y": 1}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 5,
//       "robotX": 0,
//       "robotY": 0,
//       "obstacles": [
//         {"x": 1, "y": 2},
//         {"x": 2, "y": 2},
//         {"x": 3, "y": 2}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 6,
//       "robotX": 1,
//       "robotY": 1,
//       "obstacles": [
//         {"x": 1, "y": 2},
//         {"x": 2, "y": 2}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 7,
//       "robotX": 0,
//       "robotY": 3,
//       "obstacles": [
//         {"x": 1, "y": 3},
//         {"x": 2, "y": 3},
//         {"x": 3, "y": 2}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 8,
//       "robotX": 2,
//       "robotY": 0,
//       "obstacles": [
//         {"x": 2, "y": 1},
//         {"x": 1, "y": 2},
//         {"x": 0, "y": 2}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 9,
//       "robotX": 0,
//       "robotY": 0,
//       "obstacles": [
//         {"x": 0, "y": 1},
//         {"x": 1, "y": 1},
//         {"x": 2, "y": 1},
//         {"x": 3, "y": 1}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//     {
//       "level": 10,
//       "robotX": 0,
//       "robotY": 0,
//       "obstacles": [
//         {"x": 1, "y": 0},
//         {"x": 1, "y": 1},
//         {"x": 1, "y": 2},
//         {"x": 2, "y": 2},
//         {"x": 3, "y": 2}
//       ],
//       "goal": {"x": 3, "y": 3}
//     },
//   ];
//
//   for (final level in levels) {
//     await FirebaseFirestore.instance.collection('robot_levels').add(level);
//   }
//
//   print("✅ Robot levels uploaded successfully!");
// }

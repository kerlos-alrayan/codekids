import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // رفع صورة
  Future<void> uploadImage() async {
    try {
      // استخدام ImagePicker لاختيار صورة من جهاز المستخدم
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File image = File(pickedFile.path);

        // تحديد المسار الذي سيتم تخزين الصورة فيه في Firebase Storage
        String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        UploadTask uploadTask = _storage.ref(fileName).putFile(image); // رفع الصورة
        await uploadTask.whenComplete(() => print('Image uploaded!'));
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  // رفع فيديو
  Future<void> uploadVideo() async {
    try {
      // استخدام ImagePicker لاختيار فيديو من جهاز المستخدم
      final picker = ImagePicker();
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        File video = File(pickedFile.path);

        // تحديد المسار الذي سيتم تخزين الفيديو فيه في Firebase Storage
        String fileName = 'videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
        UploadTask uploadTask = _storage.ref(fileName).putFile(video); // رفع الفيديو
        await uploadTask.whenComplete(() => print('Video uploaded!'));
      }
    } catch (e) {
      print('Error uploading video: $e');
    }
  }

  Future<String> getFileUrl(String filePath) async {
    try {
      // الحصول على الرابط المباشر للملف من Firebase Storage
      String fileUrl = await FirebaseStorage.instance.ref(filePath).getDownloadURL();
      return fileUrl;
    } catch (e) {
      print('Error getting file URL: $e');
      return ''; // في حالة حدوث خطأ
    }
  }

}

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int price;
  final String category;
  final String teacherId;
  final int videosCount;
  final String? videoUrl; // 👈 مضاف

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.teacherId,
    required this.videosCount,
    this.videoUrl,
  });

  factory CourseModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return CourseModel(
      id: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price'] ?? 0,
      category: data['category'] ?? '',
      teacherId: data['teacherId'] ?? '',
      videosCount: data['videosCount'] ?? 0,
      videoUrl: data['videoUrl'], // 👈
    );
  }
}

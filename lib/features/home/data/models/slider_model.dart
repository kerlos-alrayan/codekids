class SliderModel {
  final String title;
  final String image;
  final String courseId;

  SliderModel({
    required this.title,
    required this.image,
    required this.courseId,
  });

  factory SliderModel.fromFirestore(Map<String, dynamic> data) {
    return SliderModel(
      title: data['title'] ?? '',
      image: data['image'] ?? '',
      courseId: data['courseId'] ?? '',
    );
  }
}

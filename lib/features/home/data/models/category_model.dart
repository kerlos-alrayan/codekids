class CategoryModel {
  final String name;
  final String image;

  CategoryModel({
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromFirestore(Map<String, dynamic> data) {
    return CategoryModel(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

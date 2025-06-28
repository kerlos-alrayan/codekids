class ChildUserModel {
  final String uid;
  final String name;
  final String gender;
  final DateTime birthDate;
  final String loginCode;

  ChildUserModel({
    required this.uid,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.loginCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'loginCode': loginCode,
    };
  }

  factory ChildUserModel.fromJson(Map<String, dynamic> json) {
    return ChildUserModel(
      uid: json['uid'],
      name: json['name'],
      gender: json['gender'],
      birthDate: DateTime.parse(json['birthDate']),
      loginCode: json['loginCode'],
    );
  }
}

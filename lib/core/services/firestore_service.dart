import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/introduction/data/models/child_user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ⬅️ حفظ البيانات لأول مرة
  Future<void> saveChildData(ChildUserModel child) async {
    await _firestore
        .collection('children')
        .doc(child.uid)
        .set(child.toMap());
  }
  Future<bool> isLoginCodeTaken(String code) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('children')
        .where('loginCode', isEqualTo: code)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  // ⬅️ دالة جديدة: جلب بيانات الطفل بالكود
  Future<ChildUserModel?> getChildByCode(String code) async {
    final snapshot = await _firestore
        .collection('children')
        .where('loginCode', isEqualTo: code)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return ChildUserModel.fromJson(snapshot.docs.first.data());
    } else {
      return null;
    }
  }
}

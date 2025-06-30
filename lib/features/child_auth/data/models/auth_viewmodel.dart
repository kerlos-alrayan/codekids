import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../../data/models/child_user_model.dart';

class AuthViewModel extends ChangeNotifier {
  String _name = '';
  String _gender = '';
  DateTime? _birthDate;
  String _loginCode = '';
  String get name => _name;
  String get gender => _gender;
  DateTime? get birthDate => _birthDate;
  String get loginCode => _loginCode;
  Map<String, int> _levels = {};
  Map<String, int> get levels => _levels;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  bool isFirstTime = true;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    _name = prefs.getString('name') ?? '';
    _gender = prefs.getString('gender') ?? '';
    _loginCode = prefs.getString('loginCode') ?? '';
    final birthDateStr = prefs.getString('birthDate');
    final levelsString = prefs.getString('levels');
    if (levelsString != null) {
      _levels = _decodeLevels(levelsString);
    }

    if (birthDateStr != null) {
      _birthDate = DateTime.tryParse(birthDateStr);
    }

    _isInitialized = true;

    // نطبع كل حاجة للتأكد
    print("Init Called:");
    print("Name: $_name");
    print("Gender: $_gender");
    print("Login Code: $_loginCode");
    print("BirthDate: $_birthDate");

    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    _saveToPrefs('name', value);
    notifyListeners();
  }

  void setGender(String value) {
    _gender = value;
    _saveToPrefs('gender', value);
    notifyListeners();
  }

  void setBirthDate(DateTime value) {
    _birthDate = value;
    _saveToPrefs('birthDate', value.toIso8601String());
    notifyListeners();
  }

  void setLoginCode(String value) {
    _loginCode = value;
    _saveToPrefs('loginCode', value);
    notifyListeners();
  }

  String _encodeLevels(Map<String, int> levels) {
    return levels.entries.map((e) => '${e.key}:${e.value}').join(',');
  }

  Map<String, int> _decodeLevels(String encoded) {
    final Map<String, int> map = {};
    if (encoded.isEmpty) return map;

    for (var pair in encoded.split(',')) {
      final parts = pair.split(':');
      if (parts.length == 2) {
        map[parts[0]] = int.tryParse(parts[1]) ?? 0;
      }
    }

    return map;
  }

  Future<bool> signInWithCode(BuildContext context, String code) async {
    try {
      final firestore = FirestoreService();
      final user = await AuthService().signInAnonymously();

      final child = await firestore.getChildByCode(code); // ابحث بالكود

      if (child == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code not found! Try again.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return false;
      }

      setName(child.name);
      setGender(child.gender);
      setBirthDate(child.birthDate);
      setLoginCode(child.loginCode);
      _levels = child.levels;

      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<void> updateGameLevel(String gameId, int level) async {
    final firestore = FirestoreService();

    final child = await firestore.getChildByCode(_loginCode);
    if (child == null) return;

    final updatedLevels = Map<String, int>.from(child.levels);
    updatedLevels[gameId] = level;

    final updatedChild = ChildUserModel(
      uid: child.uid,
      name: child.name,
      gender: child.gender,
      birthDate: child.birthDate,
      loginCode: child.loginCode,
      levels: updatedLevels,
    );

    await firestore.saveChildData(updatedChild);

    _levels[gameId] = level;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('levels', _encodeLevels(child.levels));

    notifyListeners(); // 🔁 علشان تحدث الـ UI
  }

  Future<void> submit(BuildContext context, {VoidCallback? onSuccess}) async {
    print("Name: $_name");
    print("Gender: $_gender");
    print("BirthDate: $_birthDate");

    if (_name.isEmpty || _gender.isEmpty || _birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 🔄 Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final authService = AuthService();
      final firestoreService = FirestoreService();
      final isTaken = await firestoreService.isLoginCodeTaken(_loginCode);
      if (isTaken) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This code is already used! Try another one."),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final user = await authService.signInAnonymously();

      if (user == null) {
        Navigator.of(context, rootNavigator: true).pop(); // ⛔ Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Authentication failed"),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      final child = ChildUserModel(
        uid: user.uid,
        name: _name,
        gender: _gender,
        birthDate: _birthDate!,
        loginCode: _loginCode,
        levels: {},
      );

      await firestoreService.saveChildData(child);

      Navigator.of(context, rootNavigator: true).pop(); // ✅ Close loading

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Welcome! Your profile has been created 🥳"),
          backgroundColor: Colors.green,
        ),
      );

      if (onSuccess != null) onSuccess();
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop(); // ❌ Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveToPrefs(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // امسح كل حاجة
    _name = '';
    _gender = '';
    _birthDate = null;
    _loginCode = '';
    isFirstTime = true;
    notifyListeners();
    _levels = {};
  }
}

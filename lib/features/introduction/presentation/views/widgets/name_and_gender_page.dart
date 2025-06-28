import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/auth_viewmodel.dart';

class NameAndGenderPage extends StatefulWidget {
  const NameAndGenderPage({super.key});

  @override
  State<NameAndGenderPage> createState() => _NameAndGenderPageState();
}

class _NameAndGenderPageState extends State<NameAndGenderPage> {
  String? selectedGender;
  String name = '';
  DateTime? birthDate;
  final nameController = TextEditingController();


  void _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2015),
      firstDate: DateTime(2009),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      setState(() {
        birthDate = selected;
      });

      context.read<AuthViewModel>().setBirthDate(selected);
    }
  }


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [Color(0xFFFDEBEB), Color(0xFFD0F0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🎈 عنوان طفولي
            const Text(
              '🎉 Let\'s Create Your Magic Profile!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // 👧👦 اختيار الجيندر
            const Text(
              'Pick Your Character!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGenderButton('Boy', 'assets/images/gender/boy.png'),
                const SizedBox(width: 20),
                _buildGenderButton('Girl', 'assets/images/gender/girl.png'),
              ],
            ),

            const SizedBox(height: 36),

            // 🧒 الاسم
            TextField(
              controller: nameController,
              onChanged: (val) {
                context.read<AuthViewModel>().setName(val);
              },
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'What\'s your name?',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 36),

            // 🎂 تاريخ الميلاد
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cake, color: Colors.orange),
                    const SizedBox(width: 10),
                    Text(
                      birthDate != null
                          ? DateFormat('yMMMd').format(birthDate!)
                          : 'Pick your Birthday!',
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton(String label, String imagePath) {
    final isSelected = selectedGender == label;
    return GestureDetector(
      onTap: () {
        setState(() => selectedGender = label);
        context.read<AuthViewModel>().setGender(label);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.purple : Colors.grey.shade300,
                width: isSelected ? 4 : 2,
              ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isSelected ? Colors.purple : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

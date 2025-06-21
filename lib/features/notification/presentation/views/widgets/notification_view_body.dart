import 'package:codekids/core/utils/assets.dart';
import 'package:flutter/material.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AssetsData.notification),
              Text(
                'No notification, yet!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  color: Color(0xff161C2B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:codekids/core/utils/styles.dart';
import 'package:codekids/features/notification/presentation/views/widgets/notification_view_body.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFBF6EF),
        title: Text(
          'Notifications',
          style: Styles.textStyle20,
        ),
      ),
      body: const NotificationViewBody(),
    );
  }
}

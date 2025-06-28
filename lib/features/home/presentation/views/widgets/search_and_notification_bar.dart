import 'package:codekids/core/utils/app_router.dart';
import 'package:codekids/core/utils/assets.dart';
import 'package:codekids/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../introduction/data/models/auth_viewmodel.dart';

class SearchAndNotificationBar extends StatelessWidget {
  const SearchAndNotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    final String name = auth.name.trim();
    final String gender = auth.gender;
    final String displayName = name.isEmpty ? "Hi there!" : name;

    final String avatarAsset =
    gender == "Girl" ? AssetsData.girl : AssetsData.boy;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [
              Color(0xff07BAFE),
              Color(0xff5670EC),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: AssetImage(avatarAsset),
              radius: 22,
            ),
            const SizedBox(width: 12),
            Text(
              displayName,
              style: Styles.textStyle16.copyWith(color: Colors.white),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kNotifications);
              },
              icon: const Icon(
                FontAwesomeIcons.bell,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

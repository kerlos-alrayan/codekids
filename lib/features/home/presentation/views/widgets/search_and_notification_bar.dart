import 'package:codekids/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SearchAndNotificationBar extends StatelessWidget {
  const SearchAndNotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.76,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Color(0xffB7B7B7),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Color(0xffB7B7B7),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kNotifications);
              },
              icon: Icon(
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

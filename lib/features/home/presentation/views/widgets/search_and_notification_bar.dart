import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 35,
                    color: Color(0xffB7B7B7),
                  ),
                  suffixText: 'All',
                  suffixStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'Poppins',
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
              onPressed: () {},
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/views/profile/profile_page.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  final List<Widget> pageList = const [
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      width: width,
      color: kPrimary,
      height: 135.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 57.5, left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi Dan',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: kWhite,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Ready to cook for lunch?',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: kGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 25.0),
            child: GestureDetector(
              onTap: () {
                // Переходить на сторінку профілю при натисканні на аватарку
                Get.to(const ProfilePage());
              },
              child: const CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    'https://cdn.iconscout.com/icon/free/png-256/free-avatar-370-456322.png?f=webp'),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.0, right: 2.0),
                      child: Badge(
                        smallSize: 9.0,
                        backgroundColor: kRed,
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/controllers/user_controller.dart';
import 'package:recipeapp/themes/themes.dart';
import 'package:recipeapp/views/profile/profile_page.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({super.key});

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  final List<Widget> pageList = const [
    ProfilePage(),
  ];

  UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    await userController.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor = getTextColor(context);

    return Container(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      width: width,
      color: theme.colorScheme.background,
      height: 135.0.h,
      child: Obx(
        () {
          String username = userController.getUser?.username ?? '';
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $username',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Ready to cook for lunch?',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: textColor,
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
          );
        },
      ),
    );
  }
}

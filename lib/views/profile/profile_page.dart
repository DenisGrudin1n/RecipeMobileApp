import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/views/login/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: kWhite),
        ),
        backgroundColor: kPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.offAll(const LoginPage());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: kPrimary,
          ),
          const Center(
              child: Text(
            'Profile Page',
            style: TextStyle(color: kWhite),
          )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipeapp/constants/constants.dart';

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
          backgroundColor: kPrimary),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: kPrimary,
            //decoration: BoxDecoration(
            //gradient: myGradient, // Використовуйте градієнт з constants.dart
            //),
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

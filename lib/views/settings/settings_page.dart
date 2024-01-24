import 'package:flutter/material.dart';
import 'package:recipeapp/constants/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Settings',
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
            'Settings Page',
            style: TextStyle(color: kWhite),
          )),
        ],
      ),
    );
  }
}

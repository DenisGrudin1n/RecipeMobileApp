import 'package:flutter/material.dart';
import 'package:recipeapp/constants/constants.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add Recipe',
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
            'Add Recipes Page',
            style: TextStyle(color: kWhite),
          )),
        ],
      ),
    );
  }
}

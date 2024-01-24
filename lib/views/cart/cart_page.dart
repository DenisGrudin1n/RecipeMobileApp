import 'package:flutter/material.dart';
import 'package:recipeapp/constants/constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Cart',
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
            'Cart Page',
            style: TextStyle(color: kWhite),
          )),
        ],
      ),
    );
  }
}

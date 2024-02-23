import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/views/add/add_recipe_form.dart';

class AddRecipePage extends StatelessWidget {
  const AddRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Recipes',
            style: TextStyle(
                color: kWhite, fontSize: 18, fontWeight: FontWeight.w500)),
        backgroundColor: kPrimary,
        actions: [
          TextButton(
            onPressed: () => Get.to(() => const AddRecipeForm()),
            child: const Text(
              'Post your recipe',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
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
            'No custom recipes added yet',
            style: TextStyle(
                color: kWhite, fontSize: 14, fontWeight: FontWeight.w500),
          )),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/views/add/add_recipe_form.dart';

class AddRecipePage extends StatelessWidget {
  const AddRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomRecipeController customRecipeController =
        Get.find<CustomRecipeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Recipes',
            style: TextStyle(
                color: kWhite, fontSize: 18, fontWeight: FontWeight.w500)),
        backgroundColor: kPrimary,
        actions: [
          TextButton(
            onPressed: () async {
              final result = await Get.to(() => const AddRecipeForm());
              if (result != null && result is Recipe) {
                customRecipeController.addRecipe(result);
              }
            },
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
          GetX<CustomRecipeController>(
            builder: (controller) {
              List<Recipe> recipes = controller.customRecipes;
              if (recipes.isEmpty) {
                return const Center(
                  child: Text(
                    'No custom recipes added yet',
                    style: TextStyle(
                        color: kWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                );
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.only(
                      bottom: 80.0, top: 15, left: 10, right: 10),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return buildRecipeCard(recipe);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildRecipeCard(Recipe recipe) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      color: kGray2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Container(
                height: 110.0.h,
                width: 100.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                    image: FileImage(File(
                        recipe.imageUrl)), // Використовуємо шлях до зображення
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title: ${recipe.title}',
                  style: const TextStyle(fontSize: 12, color: kWhite),
                ),
                const SizedBox(height: 5),
                Text(
                  'Category: ${recipe.category}',
                  style: const TextStyle(fontSize: 12, color: kWhite),
                ),
                const SizedBox(height: 5),
                Text(
                  'Cook Time: ${recipe.cookTime} minutes',
                  style: const TextStyle(fontSize: 12, color: kWhite),
                ),
                const SizedBox(height: 10),
                Text(
                  'Description: ${recipe.description}',
                  style: const TextStyle(fontSize: 12, color: kWhite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRecipeController extends GetxController {
  RxList<Recipe> customRecipes = <Recipe>[].obs;

  void addRecipe(Recipe recipe) {
    customRecipes.add(recipe);
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/controllers/custom_recipe_controller.dart';
import 'package:recipeapp/models/custom_recipe.dart';
import 'package:recipeapp/views/custom_recipes/add_custom_recipe_form.dart';

class AddCustomRecipePage extends StatelessWidget {
  const AddCustomRecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customRecipeController = Get.find<CustomRecipeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Recipes',
          style: TextStyle(
              color: kWhite, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kPrimary,
        actions: [
          TextButton(
            onPressed: () async {
              final result = await Get.to(() => const AddCustomRecipeForm());
              if (result != null && result is CustomRecipe) {
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
              List<CustomRecipe> recipes = controller.customRecipes;
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
                    childAspectRatio: 3 / 5,
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

  Widget buildRecipeCard(CustomRecipe recipe) {
    return IntrinsicHeight(
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: kGray2,
        child: GestureDetector(
          onTap: () {
            Get.to(() => PhotoView(
                  imageProvider: FileImage(File(recipe.imageUrl)),
                ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Container(
                    height: 110.0.h,
                    width: width,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(File(recipe.imageUrl)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showDescriptionDialog(recipe.description);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title: ${recipe.title}',
                        style: const TextStyle(fontSize: 11, color: kWhite),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Category: ${recipe.category}',
                        style: const TextStyle(fontSize: 11, color: kWhite),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Cook Time: ${recipe.cookTime}',
                        style: const TextStyle(fontSize: 11, color: kWhite),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Posted by: ${recipe.postedBy}',
                        style: const TextStyle(fontSize: 11, color: kWhite),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDescriptionDialog(String description) {
    Get.dialog(
      AlertDialog(
        backgroundColor: kGray2,
        title: const Text(
          'Description',
          style: TextStyle(fontSize: 18, color: kWhite),
        ),
        content: Text(
          description,
          style: const TextStyle(fontSize: 12, color: kWhite),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Close',
              style: TextStyle(fontSize: 14, color: kWhite),
            ),
          ),
        ],
      ),
    );
  }
}

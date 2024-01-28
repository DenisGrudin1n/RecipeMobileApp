import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/controllers/favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Recipes',
          style: TextStyle(color: kWhite),
        ),
        backgroundColor: kPrimary,
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: kPrimary,
          ),
          _buildFavoriteRecipesList(), // Вставлення списку улюблених рецептів
        ],
      ),
    );
  }

  Widget _buildFavoriteRecipesList() {
    return GetX<FavoriteController>(
      builder: (favoriteController) {
        return ListView.builder(
          itemCount: favoriteController.favoriteRecipes.length,
          itemBuilder: (context, index) {
            final recipe = favoriteController.favoriteRecipes[index];
            return ListTile(
              title: Text(
                recipe.title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

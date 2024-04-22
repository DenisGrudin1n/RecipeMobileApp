import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/controllers/recipe_controller.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/themes/themes.dart';

class FavoriteRecipesPage extends StatelessWidget {
  const FavoriteRecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteRecipeController = Get.find<RecipeController>();
    final ThemeData theme = Theme.of(context);
    final Color textColor = getTextColor(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Recipes',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: theme.colorScheme.background,
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: theme.colorScheme.background,
          ),
          _buildFavoriteRecipesList(favoriteRecipeController, context),
        ],
      ),
    );
  }

  Widget _buildFavoriteRecipesList(
      RecipeController favoriteController, BuildContext context) {
    final Color textColor = getTextColor(context);

    return GetX<RecipeController>(
      builder: (favoriteController) {
        List<Recipe> recipes = favoriteController.favoriteRecipes;
        if (recipes.isEmpty) {
          return Center(
            child: Text(
              'No Favorite Recipes Added Yet',
              style: TextStyle(
                  color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80.0, top: 15),
            scrollDirection: Axis.vertical,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              if (index.isEven) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Row(
                    children: [
                      _buildFavoriteRecipeContainer(recipes[index],
                          recipeIndex: index),
                      if (index + 1 < recipes.length) const Spacer(),
                      if (index + 1 < recipes.length)
                        _buildFavoriteRecipeContainer(recipes[index + 1],
                            recipeIndex: index),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        }
      },
    );
  }

  Widget _buildFavoriteRecipeContainer(Recipe recipe,
      {required int recipeIndex}) {
    final RecipeController favoriteRecipeController = Get.find();
    final title = recipe.title;
    final imageUrl = recipe.imageUrl;
    final stars = int.parse(recipe.stars);
    final cookTime = recipe.cookTime;
    final level = recipe.level;

    final splittedTitle = title.split(' ');
    final firstTitlePart = (splittedTitle.length > 1)
        ? splittedTitle.take((splittedTitle.length) ~/ 2).join(' ')
        : '';
    final secondTitlePart = (splittedTitle.length > 1)
        ? splittedTitle.skip((splittedTitle.length) ~/ 2).join(' ')
        : '';

    return Container(
      height: 300.0.h,
      width: 165.0.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0.r),
        color: kGray2,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  favoriteRecipeController.toggleFavorite(recipe);
                },
                icon: favoriteRecipeController.isFavorite(recipe)
                    ? const Icon(
                        Icons.favorite,
                        size: 24.0,
                        color: kRed,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        size: 24.0,
                        color: kRed,
                      ),
              ),
            ),
          ),
          ClipOval(
            child: Image.network(
              imageUrl,
              alignment: Alignment.topCenter,
              height: 100.0.h,
              width: 90.0.w,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: (title.length > 20)
                ? Column(
                    children: [
                      for (var titlePart in [firstTitlePart, secondTitlePart])
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            titlePart,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: kWhite,
                            ),
                          ),
                        ),
                    ],
                  )
                : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: kWhite,
                      ),
                    ),
                  ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              stars,
              (starIndex) => const Icon(
                Icons.star,
                color: kAmber,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    Text(
                      cookTime,
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: kGray3,
                      ),
                    ),
                    const Text(
                      'min',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: kGray3,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  '|',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: kGray3,
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      level,
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: kGray3,
                      ),
                    ),
                    const Text(
                      'Lvl',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: kGray3,
                      ),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

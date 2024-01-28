import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        List<FavoriteRecipe> recipes = favoriteController.favoriteRecipes;
        if (recipes.isEmpty) {
          return const Center(
            child: Text(
              'No Favorite Recipes Added Yet',
              style: TextStyle(
                  color: kWhite, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return ListView.builder(
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
                      buildFavoriteRecipeContainer(
                          recipes[index], favoriteController),
                      if (index + 1 < recipes.length) const Spacer(),
                      if (index + 1 < recipes.length)
                        buildFavoriteRecipeContainer(
                            recipes[index + 1], favoriteController),
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

  Widget buildFavoriteRecipeContainer(
      FavoriteRecipe recipe, FavoriteController favoriteController) {
    final title = recipe.title;
    final imageUrl = recipe.imageUrl;
    final stars = recipe.stars;
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
      height: 280.0.h,
      width: 165.0.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0.r),
        color: kGray2,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  // Обробник події для зміни стану залайкано/не залайкано
                  favoriteController.removeFromFavorites(recipe);
                },
                child: const Icon(
                  Icons
                      .favorite, // або Icons.favorite_outline, залежно від стану
                  color: Colors.red,
                  size: 24.0,
                ),
              ),
            ),
          ),
          ClipOval(
            child: Image.network(
              imageUrl,
              alignment: Alignment.topCenter,
              height: 110.0.h,
              width: 100.0.w,
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
                              color: Colors.white,
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
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              int.parse(stars),
              (starIndex) => const Icon(
                Icons.star,
                color: Colors.amber,
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

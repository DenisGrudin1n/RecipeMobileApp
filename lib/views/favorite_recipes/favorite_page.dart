import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/constants/uidata.dart';
import 'package:recipeapp/controllers/favorite_controller.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late FavoriteController favoriteController;
  int startCategoryIndex = 0;
  String selectedFoodCategory = dishCategories.first;
  Map<String, List<bool>> isFavoriteMap = {};
  Timer? _removeFavoritesTimer;

  @override
  void initState() {
    super.initState();
    favoriteController = Get.find();
  }

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
          _buildFavoriteRecipesList(),
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
                      buildFavoriteRecipeContainer(recipes[index],
                          recipeIndex: index),
                      if (index + 1 < recipes.length) const Spacer(),
                      if (index + 1 < recipes.length)
                        buildFavoriteRecipeContainer(recipes[index + 1],
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

  Widget buildFavoriteRecipeContainer(FavoriteRecipe recipe,
      {required int recipeIndex}) {
    List<Map<String, String>> filteredCategories = dishes
        .where((category) => category['foodCategory'] == selectedFoodCategory)
        .toList();
    final title = recipe.title;
    final imageUrl = recipe.imageUrl;
    final stars = int.parse(recipe.stars);
    final cookTime = recipe.cookTime;
    final level = recipe.level;
    final foodCategory = recipe.foodCategory;

    final splittedTitle = title.split(' ');
    final firstTitlePart = (splittedTitle.length > 1)
        ? splittedTitle.take((splittedTitle.length) ~/ 2).join(' ')
        : '';
    final secondTitlePart = (splittedTitle.length > 1)
        ? splittedTitle.skip((splittedTitle.length) ~/ 2).join(' ')
        : '';

    isFavoriteMap.putIfAbsent(
        title, () => List.filled(filteredCategories.length, true));

    return Container(
      height: 295.0.h,
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
                  setState(() {
                    isFavoriteMap[title]![recipeIndex] =
                        !isFavoriteMap[title]![recipeIndex];

                    final recipe = FavoriteRecipe(
                      title: title,
                      imageUrl: imageUrl,
                      stars: stars.toString(),
                      cookTime: cookTime,
                      level: level,
                      foodCategory: foodCategory,
                    );

                    if (isFavoriteMap[title]![recipeIndex]) {
                      _cancelDelayedRemoveFromFavorites();
                    } else {
                      favoriteController.removeFromFavorites(recipe);
                    }
                  });
                  _delayedRemoveFromFavorites(
                      recipe, !isFavoriteMap[title]![recipeIndex]);
                },
                child: Icon(
                  isFavoriteMap[title]![recipeIndex]
                      ? Icons.favorite
                      : Icons.favorite_outline,
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
              stars,
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

  void _cancelDelayedRemoveFromFavorites() {
    _removeFavoritesTimer?.cancel();
  }

  void _delayedRemoveFromFavorites(FavoriteRecipe recipe, bool wasFavorite) {
    const Duration delay = Duration(seconds: 1);
    _removeFavoritesTimer = Timer(delay, () {
      if (wasFavorite && favoriteController.isFavorite(recipe)) {
        favoriteController.removeFromFavorites(recipe);
      }
    });
  }
}

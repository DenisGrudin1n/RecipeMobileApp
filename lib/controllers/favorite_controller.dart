import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final RxList<FavoriteRecipe> favoriteRecipes = <FavoriteRecipe>[].obs;

  void addToFavorites(FavoriteRecipe recipe) {
    favoriteRecipes.add(recipe);
  }

  void removeFromFavorites(FavoriteRecipe recipe) {
    favoriteRecipes.remove(recipe);
  }

  bool isFavorite(FavoriteRecipe recipe) {
    return favoriteRecipes.contains(recipe);
  }
}

class FavoriteRecipe {
  final String title;
  final String imageUrl;
  final String stars;
  final String cookTime;
  final String level;

  FavoriteRecipe({
    required this.title,
    required this.imageUrl,
    required this.stars,
    required this.cookTime,
    required this.level,
  });
}

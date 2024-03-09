import 'package:get/get.dart';
import 'package:recipeapp/models/recipe.dart';

class RecipeController extends GetxController {
  final RxList<Recipe> favoriteRecipes = <Recipe>[].obs;

  void toggleFavorite(Recipe recipe) {
    if (favoriteRecipes.contains(recipe)) {
      favoriteRecipes.remove(recipe);
    } else {
      favoriteRecipes.add(recipe);
    }
  }

  bool isFavorite(Recipe recipe) {
    return favoriteRecipes.contains(recipe);
  }
}

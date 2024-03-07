import 'package:get/get.dart';
import 'package:recipeapp/models/custom_recipe.dart';

class CustomRecipeController extends GetxController {
  RxList<CustomRecipe> customRecipes = <CustomRecipe>[].obs;

  void addRecipe(CustomRecipe recipe) {
    customRecipes.add(recipe);
  }
}

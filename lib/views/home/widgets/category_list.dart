import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/constants/uidata.dart';
import 'package:recipeapp/controllers/recipe_controller.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/themes/themes.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int startCategoryIndex = 0;
  String selectedFoodCategory = dishCategories.first;
  List<Map<String, String>> get filteredCategories {
    return dishes
        .where((category) => category['foodCategory'] == selectedFoodCategory)
        .toList();
  }

  final favoriteRecipeController = Get.find<RecipeController>();

  @override
  void initState() {
    super.initState();
  }

  void _changeCategory(bool isIncrement) {
    setState(() {
      startCategoryIndex = (startCategoryIndex +
              (isIncrement ? 1 : -1) +
              dishCategories.length) %
          dishCategories.length;
      selectedFoodCategory = dishCategories[startCategoryIndex];
    });
  }

  Widget buildCategoryContainer(int index) {
    final Map<String, String> category = filteredCategories[index];
    final title = category['title']!;
    final imageUrl = category['imageUrl']!;
    final stars = int.parse(category['stars']!);

    final splittedTitle = title.split(' ');
    final firstTitlePart = (splittedTitle.length > 1)
        ? splittedTitle.take((splittedTitle.length) ~/ 2).join(' ')
        : '';
    final secondTitlePart = (splittedTitle.length > 1)
        ? splittedTitle.skip((splittedTitle.length) ~/ 2).join(' ')
        : '';

    final recipe = Recipe(
      title: title,
      imageUrl: imageUrl,
      stars: stars.toString(),
      cookTime: category['cookTime']!,
      level: category['level']!,
      foodCategory: category['foodCategory']!,
    );

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
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  favoriteRecipeController.toggleFavorite(recipe);
                },
                icon: Obx(() {
                  return favoriteRecipeController.isFavorite(recipe)
                      ? const Icon(
                          Icons.favorite,
                          size: 24.0,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          size: 24.0,
                          color: Colors.red,
                        );
                }),
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
                      category['cookTime']!,
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
                      category['level']!,
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

  @override
  Widget build(BuildContext context) {
    final Color textColor = getTextColor(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 45.0, right: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  AntDesign.leftcircleo,
                  color: textColor,
                ),
                onPressed: () => _changeCategory(false),
              ),
              Center(
                child: Text(
                  dishCategories[startCategoryIndex],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  AntDesign.rightcircleo,
                  color: textColor,
                ),
                onPressed: () => _changeCategory(true),
              ),
            ],
          ),
        ),
        Container(
          height: height,
          width: width,
          padding: const EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 440.0),
            scrollDirection: Axis.vertical,
            children: List.generate(filteredCategories.length, (i) {
              if (i.isEven) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  child: Row(
                    children: [
                      buildCategoryContainer(i),
                      if (i + 1 < filteredCategories.length) const Spacer(),
                      if (i + 1 < filteredCategories.length)
                        buildCategoryContainer(i + 1),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        ),
      ],
    );
  }
}

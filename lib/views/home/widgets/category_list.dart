import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/constants/uidata.dart';
import 'package:recipeapp/controllers/favorite_controller.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int startCategoryIndex = 0;
  String selectedFoodCategory = dishCategories.first;
  Map<String, List<bool>> isFavoriteMap = {};

  void _changeCategory(bool isIncrement) {
    setState(() {
      startCategoryIndex = (startCategoryIndex +
              (isIncrement ? 1 : -1) +
              dishCategories.length) %
          dishCategories.length;
      selectedFoodCategory = dishCategories[startCategoryIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCategories = dishes
        .where((category) => category['foodCategory'] == selectedFoodCategory)
        .toList();

    Widget buildCategoryContainer(int index) {
      final title = filteredCategories[index]['title']!;
      final splittedTitle = title.split(' ');
      final firstTitlePart = (splittedTitle.length > 1)
          ? splittedTitle.take((splittedTitle.length) ~/ 2).join(' ')
          : '';
      final secondTitlePart = (splittedTitle.length > 1)
          ? splittedTitle.skip((splittedTitle.length) ~/ 2).join(' ')
          : '';
      final key = title;
      isFavoriteMap.putIfAbsent(
          key, () => List.filled(filteredCategories.length, false));

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
                    setState(() {
                      isFavoriteMap[key]![index] = !isFavoriteMap[key]![index];
                      if (isFavoriteMap[key]![index]) {
                        // Додаємо рецепт до улюблених
                        FavoriteController favoriteController = Get.find();
                        favoriteController.addToFavorites(
                          FavoriteRecipe(title: title),
                        );
                      } else {
                        // Видаляємо рецепт з улюблених
                        FavoriteController favoriteController = Get.find();
                        favoriteController.removeFromFavorites(
                          FavoriteRecipe(title: title),
                        );
                      }
                    });
                  },
                  child: Icon(
                    isFavoriteMap[key]![index]
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
                filteredCategories[index]['imageUrl']!,
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
                int.parse(filteredCategories[index]['stars']!),
                (starIndex) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.0,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        filteredCategories[index]['cookTime']!,
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
                        filteredCategories[index]['level']!,
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 45.0, right: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  AntDesign.leftcircleo,
                  color: kWhite,
                ),
                onPressed: () {
                  _changeCategory(false);
                },
              ),
              Center(
                child: Text(
                  dishCategories[startCategoryIndex],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: kWhite,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  AntDesign.rightcircleo,
                  color: kWhite,
                ),
                onPressed: () {
                  _changeCategory(true);
                },
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

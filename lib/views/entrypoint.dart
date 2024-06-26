import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/controllers/tab_index_controller.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:recipeapp/themes/themes.dart';
import 'package:recipeapp/views/custom_recipes/add_custom_recipe_page.dart';
import 'package:recipeapp/views/google_maps/google_maps_page.dart';
import 'package:recipeapp/views/favorite_recipes/favorite_recipes_page.dart';
import 'package:recipeapp/views/home/home_page.dart';
import 'package:recipeapp/views/settings/settings_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> pageList = const [
    HomePage(),
    FavoriteRecipesPage(),
    AddCustomRecipePage(),
    GoogleMapsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabIndexController());
    final ThemeData theme = Theme.of(context);
    final Color textColor = getTextColor(context);

    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            pageList[controller.tabIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: theme.colorScheme.background),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 0.0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  unselectedIconTheme: IconThemeData(color: textColor),
                  selectedIconTheme: IconThemeData(color: textColor),
                  iconSize: 26.0,
                  onTap: (value) {
                    controller.setTabIndex = value;
                  },
                  currentIndex: controller.tabIndex,
                  items: [
                    const BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 15.0, left: 15.0),
                          child: Icon(AntDesign.home),
                        ),
                        label: 'Home'),
                    const BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 15.0, left: 7.5),
                          child: Icon(AntDesign.hearto),
                        ),
                        label: 'Favorite Recipes'),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Icon(
                            AntDesign.pluscircle,
                            color:
                                controller.tabIndex == 2 ? kDark : kAmberAccent,
                            size: 34.0,
                          ),
                        ),
                        label: 'Add Custom Recipe'),
                    const BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 15.0, right: 7.5),
                          child: Icon(Icons.map_outlined),
                        ),
                        label: 'Google Maps'),
                    const BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: Icon(AntDesign.setting),
                        ),
                        label: 'Settings'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

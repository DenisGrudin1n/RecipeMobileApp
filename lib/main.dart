import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/controllers/custom_recipe_controller.dart';
import 'package:recipeapp/controllers/google_maps_controller.dart';
import 'package:recipeapp/controllers/recipe_controller.dart';
import 'package:recipeapp/controllers/tab_index_controller.dart';
import 'package:recipeapp/controllers/user_controller.dart';
import 'package:recipeapp/firebase_options.dart';
import 'package:recipeapp/views/entrypoint.dart';
import 'package:recipeapp/views/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<RecipeController>(RecipeController());
    Get.put<UserController>(UserController());
    Get.put<TabIndexController>(TabIndexController());
    Get.put<CustomRecipeController>(CustomRecipeController());
    Get.put<GoogleMapsController>(GoogleMapsController());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375.0, 825.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Recipe',
          theme: ThemeData(
            scaffoldBackgroundColor: kOffWhite,
            iconTheme: const IconThemeData(color: kDark),
            primarySwatch: Colors.grey,
          ),
          initialBinding: AppBindings(),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const MainScreen();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: kDark),
                  );
                }
                return const LoginPage();
              }),
        );
      },
    );
  }
}

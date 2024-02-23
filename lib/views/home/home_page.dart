import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/views/home/widgets/appbar.dart';
import 'package:recipeapp/views/home/widgets/category_list.dart';
import 'package:recipeapp/views/home/widgets/dailymeal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.h),
        child: const AppBarHome(),
      ),
      body: const SafeArea(
        child: Column(children: [DailyMealBlock(), CategoryList()]),
      ),
    );
  }
}

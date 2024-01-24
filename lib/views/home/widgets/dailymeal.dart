import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipeapp/constants/constants.dart';

class DailyMealBlock extends StatelessWidget {
  const DailyMealBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Container(
        height: 170.0.h,
        width: width,
        padding: const EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: kWhite,
          image: const DecorationImage(
            image: NetworkImage(
                'https://static.tildacdn.com/tild3937-6634-4739-a436-613366353034/meal.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              _buildText('Meal Of The Day', kWhite, 11, FontWeight.w500),
              const Padding(padding: EdgeInsets.only(top: 25.0)),
              _buildText('Salmon Dish', kYellow, 16, FontWeight.w500),
              const Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(
                children: [
                  _buildIconText(Icons.timelapse, '15 min', kDark),
                  const Padding(padding: EdgeInsets.only(left: 15.0)),
                  _buildIconText(Icons.verified_outlined, 'easy lvl', kDark),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(
      String text, Color color, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text, Color iconColor) {
    return Column(
      children: [
        Container(
          height: 24.0.h,
          width: 24.0.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0.r),
            color: Colors.amber,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 18.0,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 3.0)),
        _buildText(text, kYellow, 10.0, FontWeight.w500),
      ],
    );
  }
}

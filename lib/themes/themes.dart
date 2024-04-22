import 'package:flutter/material.dart';
import 'package:recipeapp/constants/constants.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade100,
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: kPrimary,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
);

Color getTextColor(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return theme.brightness == Brightness.light ? Colors.black : Colors.white;
}

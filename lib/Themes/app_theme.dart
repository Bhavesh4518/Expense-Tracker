

import 'package:expense_tracker/Themes/textformfield.dart';
import 'package:flutter/material.dart';

import 'elevated_button.dart';
import 'outlined_button.dart';

class MyAppTheme {

  MyAppTheme();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: MyTextFormFields.lightInputDecorationTheme,
    outlinedButtonTheme: MyOutLinedButton.lightOutLinedButton,

  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.black,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: MyTextFormFields.darkInputDecorationTheme,  // TextField them
    outlinedButtonTheme: MyOutLinedButton.darkOutLinedButton,

  );
}
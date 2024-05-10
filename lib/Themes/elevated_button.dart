

import 'package:flutter/material.dart';

class MyElevatedButtonTheme{
  MyElevatedButtonTheme._(); // to avoid creating instance

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.yellow,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.grey,
        side: const BorderSide(color: Colors.transparent),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.yellow,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.grey,
        side: const BorderSide(color: Colors.transparent),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )
  );

}
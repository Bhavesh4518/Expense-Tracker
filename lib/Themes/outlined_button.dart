

import 'package:flutter/material.dart';

class MyOutLinedButton {

  MyOutLinedButton._();

  static final lightOutLinedButton = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.deepPurpleAccent),
          textStyle: const TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14),
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))
      )
  );
  static final darkOutLinedButton = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.deepPurpleAccent),
          textStyle: const TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 14),
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))
      )
  );
}
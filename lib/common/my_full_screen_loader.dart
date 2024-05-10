
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'animation_widet.dart';

class MyFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => SizedBox(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  MyAnimationWidget(
                    text: text,
                    animation: animation,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

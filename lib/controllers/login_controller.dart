
import 'package:expense_tracker/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../common/my_full_screen_loader.dart';
import '../data/repositories/authentication_repo.dart';

class LoginController extends GetxController{

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final userController = Get.put(UserController());


  @override
  void onInit() {
    final rememberedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final rememberedPassword = localStorage.read('REMEMBER_ME_PASSWORD');

    if (rememberedEmail != null) {
      email.text = rememberedEmail;
    }

    if (rememberedPassword != null) {
      password.text = rememberedPassword;
    }

    super.onInit();
  }


  Future<void> emailAndPasswordSignIn() async {
    try {
      MyFullScreenLoader.openLoadingDialog(
          'Logging you in....', 'assets/ani.json');

      ///Check Internet connectivity


      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      /// Login user using Email and password and Authentication
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      /// Remove loader
      MyFullScreenLoader.stopLoading();

      /// Redirect
      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      MyFullScreenLoader.stopLoading();

    }
  }

  Future<void> googleSignIn() async {
    try{
      // Start Loading
      MyFullScreenLoader.openLoadingDialog('Logging you in.....', 'assets/ani.json');

      // Check Internet connectivity


      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      ///Save user Record
      await userController.saveUserRecord(userCredentials);

      /// remove loading
      MyFullScreenLoader.stopLoading();

      /// Redirect
      AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      MyFullScreenLoader.stopLoading();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/my_full_screen_loader.dart';
import '../data/repositories/authentication_repo.dart';
import '../data/repositories/user_repo.dart';
import '../models/user_model.dart';
import '../sign_up/verify_email.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();
  final hidePassword  =true.obs;
  final privacyPolicy  =true.obs;
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try{
      MyFullScreenLoader.openLoadingDialog('We are processing your information','assets/expense.jpg');

      /// Privacy policy check
      if(!privacyPolicy.value){
        MyFullScreenLoader.stopLoading();
        return;
      }

      /// Register User  inn firestore Authentication & Save user data in the FireStore
      final userCredential =  await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      /// Save Authenticated user data in Firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        name: name.text.trim(),
        email: email.text.trim(),
        profilePic: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUSerRecord(newUser);

      MyFullScreenLoader.stopLoading();
      Get.to(() => VarifyEmailScreen(email: email.text.trim(),));

    }catch(e){
      MyFullScreenLoader.stopLoading();

    }
  }
}
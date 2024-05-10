

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../common/success_screen.dart';
import '../data/repositories/authentication_repo.dart';

class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();

  // Send Email whenever Verify screen appears $ set Timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email verification Link
  sendEmailVerification() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();

    }catch(e){
      throw e.toString();
    }
  }

  /// Timer to automatically redirect in email verification
  setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1), (timer) async{
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false){
        timer.cancel();
        Get.off(() => SuccessScreen(
          image: 'assets/signup.png',
          title: 'Your Account Created',
          subtitle: 'Explore Yourself',
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        )
        );
      }
    });
  }
  checkEmailVerificationStatus(){
    final  currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(() => SuccessScreen(
        image: 'assets/signup.png',
        title: 'Created',
        subtitle: 'Your account',
        onPressed: () => AuthenticationRepository.instance.screenRedirect(),
      )
      );
    }
  }
}
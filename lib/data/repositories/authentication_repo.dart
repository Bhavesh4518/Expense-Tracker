

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/local_storagew.dart';
import '../../login_screen/login_screen.dart';
import '../../navigation_bar.dart';
import '../../onBoarding/onBoarding_screen.dart';
import '../../sign_up/verify_email.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get authenticated User data
  User? get authUser => _auth.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        /// Initialize user specific storage
        await MyLocalStorage.init(user.uid);
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() =>
            VarifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => OnBoardingScreen());
    }
  }

//--------------------------------Email And Password Authentication--------------------------------
  /// Email Sign In
  Future<UserCredential> loginWithEmailAndPassword(String email,
      String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw e.toString();
    }
  }

  /// Email Register
  Future<UserCredential> registerWithEmailAndPassword(String email,
      String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw e.toString();
    }
  }

  /// Email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      throw e.toString();
    }
  }

  // Forget password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e.toString();
    }
  }

  //----------------------------------Social Authentications---------------------------------------------
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from request
      final GoogleSignInAuthentication? googleAuth =
      await userAccount?.authentication;

      // Create a new Credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // once signed in , return UserCredentials
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.toString());
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.message.toString());
    }
  }

//--------------------------------------Logout Auth--------------------------------------------------
  /// Logout User
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.toString());
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.message.toString());
    }
  }
}

  /// Delete account


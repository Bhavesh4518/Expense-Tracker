
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/user_repo.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetail();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      /// first update rx user record then check data is already stored or not
      await fetchUserRecord();
      // if  not then
      if(user.value.id.isNotEmpty){
        if (userCredential != null) {
          // convert name to first name and last name
          // Map Data
          final user = UserModel(
            id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
            profilePic: userCredential.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUSerRecord(user);
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }


  // Upload Profile Image


}

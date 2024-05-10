
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import 'authentication_repo.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  /// Function to save user data in firestore
  Future<void> saveUSerRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJSON());
    } catch (e) {
      throw e.toString();
    }
  }

  // Function to fetch user data
  Future<UserModel> fetchUserDetail() async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(
          AuthenticationRepository.instance.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
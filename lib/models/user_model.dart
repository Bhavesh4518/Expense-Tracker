
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String name;
  final String email;
  String profilePic;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePic,
  });

  static UserModel empty() =>
      UserModel(id: '',
          name: '',
          email: '',
          profilePic: '');

  // Convert model to JSON structure for storing data in firebase
  Map<String, dynamic> toJSON() {
    return {
      'first_name': name,
      'email': email,
      'profile_picture': profilePic,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['first_name'] ?? '',
        email: data['email'] ?? '',
        profilePic: data['profile_picture'] ?? '',
      );
    } else {
      // Handle the case when data is null (optional)
      // You can return a default UserModel or throw an exception.
      return UserModel.empty();
    }
  }

}
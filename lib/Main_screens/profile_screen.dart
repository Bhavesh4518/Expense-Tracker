
import 'package:expense_tracker/controllers/user_controller.dart';
import 'package:expense_tracker/data/repositories/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthenticationRepository.instance;
    final userController = Get.put(UserController());
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight * 1.2,),
              Row(
                children: [
                  const CircleAvatar(minRadius: 45, child: Icon(Iconsax.profile_2user)),
                  const SizedBox(width: 18,),
                  Obx(() => Text(userController.user.value.name.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                  const SizedBox(width: 40,),
                  const Expanded(child: Icon(Iconsax.edit))
                ],
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(onPressed: () => controller.logout(),child: const Text('Logout'),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

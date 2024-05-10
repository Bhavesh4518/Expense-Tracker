
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/verify_email_controller.dart';
import '../data/repositories/authentication_repo.dart';

class VarifyEmailScreen extends StatelessWidget {
  const VarifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: const Icon(Icons.clear)),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [

              /// Image
              const Image(
                  height : 200,
                  image: AssetImage('assets/signup.png')),
              const SizedBox(height: 24),

              /// Title & Subtitle
              Text('Verify your Email address!',style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: 16),
              Text(email ?? '',style: Theme.of(context).textTheme.labelLarge,textAlign:TextAlign.center,),
              const SizedBox(height: 16,),
              Text("Confirm your Email address",style: Theme.of(context).textTheme.labelMedium,textAlign:TextAlign.center,),
              const SizedBox(height: 24,),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: () => controller.sendEmailVerification(), child: const Text('Resend Email'))
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:expense_tracker/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../common/social_buttons.dart';
import '../common/widgets/login_divider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Sign up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset('assets/signup.png'),
              TextFormField(
                controller: controller.name,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Name',

                ),
              ),
              const SizedBox(height: 8,),
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email)

                ),
              ),
              const SizedBox(height: 8,),
              Obx(
                    () => TextFormField(
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
              //    validator: (value) => MyValidations.validatePassword(value),
                  expands : false,
                  decoration:  InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              Row(
                children: [
                  SizedBox(height: 24 , width: 24 ,child: Obx( () => Checkbox(value: controller.privacyPolicy.value,
                      onChanged: (value){
                        controller.privacyPolicy.value = !controller.privacyPolicy.value;
                      }
                  )
                  )
                  ),
                  SizedBox(width: 12,),
                  const Text('By signing up, I agree to the T&C',overflow: TextOverflow.ellipsis,maxLines: 3,softWrap: true,)
                ],
              ),
              const SizedBox(height: 34,),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: () => controller.signup(), child: const Text('Create acccount'))),
              const SizedBox(height: 12,),

              const MyFormDivider(dividerText: 'or sign up with'),
              const SizedBox(height: 12,),
              const MySocialButtons()

            ],
          ),
        ),
      ),
    );
  }
}

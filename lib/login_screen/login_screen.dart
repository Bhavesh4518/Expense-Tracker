import 'package:expense_tracker/common/social_buttons.dart';
import 'package:expense_tracker/common/widgets/login_divider.dart';
import 'package:expense_tracker/controllers/login_controller.dart';
import 'package:expense_tracker/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/expense.jpg'),
              const Text('Welcome Back,',style : TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              const Text('Login to explore more',style : TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey)),
              const SizedBox(height: 24,),
              TextFormField(
                controller: controller.email,
                decoration: const  InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email'
                ),

              ),
              const SizedBox(height: 12,),
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
              const SizedBox(height: 8,),
              Row(
                children: [
                  SizedBox(height: 24 , width: 24 ,child: Obx( () => Checkbox(value: controller.rememberMe.value,
                      onChanged: (value){
                        controller.rememberMe.value = !controller.rememberMe.value;
                      }
                  )
                  )
                  ),
                  SizedBox(width: 5,),
                  Text("Remember Me")
                  
                ],
              ),
              const SizedBox(height:18,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: () => controller.emailAndPasswordSignIn(), child: const Text('Login'))),
              const SizedBox(height: 12,),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text('Sign up'))),
              const SizedBox(height: 16,),

              const MyFormDivider(dividerText: 'or login with'),
              const SizedBox(height: 12,),
              const MySocialButtons()
              
            ],
          ),
        ),
      ),
    );
  }
}

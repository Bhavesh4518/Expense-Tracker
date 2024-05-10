
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onPressed});

  final String image , title , subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 56, left: 24, right: 24, bottom: 24),
          child: Column(
            children: [
              Image(
                  height: 300,
                  image: AssetImage(image)),
              const SizedBox(height: 24,),

              /// Title & Subtitle
              Text(title, style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 16,),
              Text(subtitle, style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 24),

              /// Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: onPressed, child: const Text('Continue'))),
              const SizedBox(height: 16),


            ],
          ),

        ),
      ),
    );
  }
}

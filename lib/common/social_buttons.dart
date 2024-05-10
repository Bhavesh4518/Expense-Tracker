
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MySocialButtons extends StatelessWidget {
  const MySocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  //  final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200,),borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            icon: const Icon(Iconsax.omega_circle
            ), onPressed: () => {}),
        ),
        const SizedBox(width: 16,),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200,),borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            icon: const Icon(Iconsax.omega_square,), onPressed: () {  },
            ),
        ),

      ],
    );
  }
}
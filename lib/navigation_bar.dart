
import 'package:expense_tracker/Main_screens/profile_screen.dart';
import 'package:expense_tracker/all_transactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'Main_screens/Home_screen/home_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
              indicatorColor: Colors.yellow.shade100,
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
          controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.transaction_minus4), label: 'transactions'),
            NavigationDestination(
                icon: Icon(Iconsax.unlimited), label: 'Budget'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    const AllTransactionsScreen(),
    Container(color: Colors.deepPurple,),
    const MyProfileScreen(),
  ];

  void home() {
    final home = selectedIndex == 1.obs;
  }
}

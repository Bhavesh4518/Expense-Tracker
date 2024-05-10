

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingWidget(
                image: 'assets/addIncome.jpg',
                title: "Add your Expenses and income",
                subtitle:
                "Add Your incomes and expenses for managing your portfolio",
              ),
              OnBoardingWidget(
                image: 'assets/budget.jpg',
                title: "Set your budget",
                subtitle:
                'see your budget for managing your capital',
              ),
              OnBoardingWidget(
                image: 'assets/transactions.jpg',
                title: "manage your budget",
                subtitle:
                'see your all transactions , remove unwanted',
              ),
            ],
          ),
          const OnBoardingSkipWidget(),
          OnBoardingNavigationDots(),

          //Circular button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  //  final dark = MyHelperFunctions.isDarkMode(context);
    return Positioned(
        right: 24,
        bottom: kBottomNavigationBarHeight - 10,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const CircleBorder()),
            onPressed: () {
              OnBoardingController.instance.nextPage();
            },
            child: const Icon(Icons.arrow_forward_ios_rounded)));
  }
}

class OnBoardingNavigationDots extends StatelessWidget {
  final controller = OnBoardingController.instance;
  OnBoardingNavigationDots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
 //   final dark = MyHelperFunctions.isDarkMode(context);
    return Positioned(
        left: 18,
        bottom: kBottomNavigationBarHeight + 15,
        child: SmoothPageIndicator(
            effect: const ExpandingDotsEffect(
                activeDotColor:  Colors.black,
                dotHeight: 6),
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 3));
  }
}

class OnBoardingSkipWidget extends StatelessWidget {
  const OnBoardingSkipWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  //  final dark = MyHelperFunctions.isDarkMode(context);
    return Positioned(
        top: kToolbarHeight,
        right: 5,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: const Text(
            'skip',
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ));
  }
}

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            image: AssetImage(image)),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

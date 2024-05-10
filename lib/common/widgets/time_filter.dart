import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeFilter extends StatelessWidget {
  const TimeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimeFilterController());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Colors.yellow.shade200,
            Colors.yellow.shade50,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),

      ),
      child: Row(
        children: [
          Expanded(child: _buildFilterOption('Today', 0)),
          Expanded(child: _buildFilterOption('Week', 1)),
          Expanded(child: _buildFilterOption('Month', 2)),
          Expanded(child: _buildFilterOption('Year', 3)),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String text, int index) {
    final TimeFilterController controller = Get.put(TimeFilterController());
    return GestureDetector(
      onTap: () {
        controller.changeSelectedIndex(index);
      },
      child: Obx(
          () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: controller.selectedIndex.value == index
                ? Colors.yellow.shade100
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: controller.selectedIndex.value == index
                    ? Colors.orange
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimeFilterController extends GetxController {
  RxInt selectedIndex = 0.obs;
  late StreamController<String> _timeFrameStreamController;

  @override
  void onInit() {
    super.onInit();
    _timeFrameStreamController = StreamController<String>.broadcast();
  }

  Stream<String> get timeFrameStream => _timeFrameStreamController.stream;

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    _updateTimeFrame();
  }

  void _updateTimeFrame() {
    String timeFrame;
    switch (selectedIndex.value) {
      case 0:
        timeFrame = 'Today';
        break;
      case 1:
        timeFrame = 'Week';
        break;
      case 2:
        timeFrame = 'Month';
        break;
      case 3:
        timeFrame = 'Year';
        break;
      default:
        timeFrame = 'Today'; // Default to Today
        break;
    }
    _timeFrameStreamController.add(timeFrame);
  }
}

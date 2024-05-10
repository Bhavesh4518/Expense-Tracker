

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common/widgets/time_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/my_full_screen_loader.dart';

class ExpenseController extends GetxController{
  static ExpenseController get instance => Get.find();
  final timeFilterController = Get.put(TimeFilterController());
  final expense = TextEditingController();
  final category = TextEditingController();
  final wallet = TextEditingController();
  final des = TextEditingController();
  final selectedOption = 'Other'.obs;
  RxString selectedTimeFrame = 'Today'.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void updateTimeFrame(String timeFrame) {
    selectedTimeFrame.value = timeFrame;
  }


  void onDropdownChanged(String? newValue) {
    if (newValue != null) {
      selectedOption.value = newValue;
    }
  }


  void saveExpenseData(String category,String type) async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Create a reference to the Firestore database
        final firestore = FirebaseFirestore.instance;

        if (!formKey.currentState!.validate()) {
          return;
        }


        // Get the user's ID
        String userId = user.uid;

        // Create a new document in the "expenses" collection under the user's document
        DocumentReference expenseRef = firestore.collection('Users').doc(userId).collection('expenses').doc();

        // Save expense data to Firestore
        await expenseRef.set({
          'amount': double.parse(expense.text),
          'category': selectedOption.value.toString(),
          'description': des.text,
          'wallet': wallet.text,
          'timestamp': Timestamp.now(),
          'type' : type,
        });

        // Show success message
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Expense saved successfully')),
        );
      }
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Failed to save expense: $error')),
      );
    }
  }
  Future<double> getTotalExpense() async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Create a reference to the Firestore database
        final firestore = FirebaseFirestore.instance;

        // Get the user's ID
        String userId = user.uid;

        // Query the expenses collection for the user
        QuerySnapshot querySnapshot = await firestore.collection('Users').doc(userId).collection('expenses')
            .where('type', isEqualTo: 'expense') // Filter documents where 'type' is equal to 'expense'
            .get();

        // Sum up the 'amount' field for each document
        double totalExpense = querySnapshot.docs.fold(0, (previousValue, doc) {
          return previousValue + (doc['amount'] ?? 0); // Add the amount to the previous total, handle null values with 0
        });

        return totalExpense;
      }
      return 0; // Return 0 if the user is not logged in
    } catch (error) {
      // Handle error
      print('Error getting total expense: $error');
      return 0; // Return 0 in case of error
    }
  }
  Future<double> getTotalIncome() async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Create a reference to the Firestore database
        final firestore = FirebaseFirestore.instance;

        // Get the user's ID
        String userId = user.uid;

        // Query the expenses collection for the user
        QuerySnapshot querySnapshot = await firestore.collection('Users').doc(userId).collection('expenses')
            .where('type', isEqualTo: 'income') // Filter documents where 'type' is equal to 'expense'
            .get();

        // Sum up the amount field for each document
        double totalExpense = querySnapshot.docs.fold(0, (previousValue, doc) {
          return previousValue + (doc['amount'] ?? 0); // Add the amount to the previous total, handle null values with 0
        });

        return totalExpense;
      }
      return 0; // Return 0 if the user is not logged in
    } catch (error) {
      // Handle error
      print('Error getting total expense: $error');
      return 0; // Return 0 in case of error
    }
  }
  IconData getTransactionIcon(String type) {
    return type == 'income' ? Icons.add  : Icons.remove;
  }

  DateTime getStartTime() {
    final DateTime now = DateTime.now();
    DateTime startTime;

    switch (timeFilterController.selectedIndex.value) {
      case 0: // Today
        startTime = DateTime(now.year, now.month, now.day);
        break;
      case 1: // Week
        startTime = DateTime(now.year, now.month, now.day - now.weekday + 1);
        break;
      case 2: // Month
        startTime = DateTime(now.year, now.month, 1);
        break;
      case 3: // Year
        startTime = DateTime(now.year, 1, 1);
        break;
      default: // Default to Today
        startTime = DateTime(now.year, now.month, now.day);
        break;
    }

    return startTime;
  }



}

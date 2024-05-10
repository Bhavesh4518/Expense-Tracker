import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/all_transactions.dart';
import 'package:expense_tracker/common/widgets/month_dropdown.dart';
import 'package:expense_tracker/common/widgets/time_filter.dart';
import 'package:expense_tracker/controllers/expenses_controller.dart';
import 'package:expense_tracker/expense/add_expense_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  final TimeFilterController timeFilterController = Get.put(TimeFilterController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpenseController());

    return Scaffold(
      backgroundColor: Colors.white70,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 1.2 * kToolbarHeight, 20, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(4, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellowAccent,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-4, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellowAccent,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.3),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(color: Colors.yellow.shade200),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 110.0, sigmaY: 130.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      OutlinedButton(onPressed: () {}, child: const Text('November')),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Center(
                    child: Text(
                      'Account Balance',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  FutureBuilder<List<double>>(
                    future: Future.wait([
                      controller.getTotalIncome(),
                      controller.getTotalExpense(),
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error'));
                      } else {
                        double totalIncome = snapshot.data?[0] ?? 0;
                        double totalExpense = snapshot.data?[1] ?? 0;
                        double accountBalance = totalIncome - totalExpense;
                        return Center(
                          child: Text(
                            '\$$accountBalance',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF13FF2E),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(child: Icon(Iconsax.money_recive, color: Colors.green)),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Income', style: TextStyle(color: Colors.white)),
                                  FutureBuilder<double>(
                                    future: controller.getTotalIncome(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}'); // Show error message if there's an error
                                      } else {
                                        // Show total expense
                                        return Text(
                                            '\$${snapshot.data?.toStringAsFixed(0)}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0000),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(child: Icon(Iconsax.money_send, color: Colors.red)),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Expenses', style: TextStyle(color: Colors.white)),
                                  FutureBuilder<double>(
                                    future: controller.getTotalExpense(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}'); // Show error message if there's an error
                                      } else {
                                        // Show total expense
                                        return Text(
                                            '\$${snapshot.data?.toStringAsFixed(0)}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const TimeFilter(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => const AllTransactionsScreen()),
                        child: const Text('See All'),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('expenses').limit(6)
                          .orderBy('timestamp', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }

                        if (snapshot.data == null) {
                          return const Center(child: Text('No Data Yet, Add income/expenses'));
                        }

                        var transactions = snapshot.data!.docs;
                        transactions = transactions.reversed.toList();


                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final Map<String, dynamic> transaction =
                              transactions[index].data() as Map<String, dynamic>;
                              final IconData icon = controller.getTransactionIcon(transaction['type']);
                              final Color amountColor = transaction['type'] == 'income' ? Colors.green : Colors.red;



                              return Dismissible(
                                key: Key(transactions[index].id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                                onDismissed: (direction) {
                                  // Remove the item from the database
                                  FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .collection('expenses')
                                      .doc(transactions[index].id)
                                      .delete();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white70,
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(child: Icon(icon)),
                                      title: Text(transaction['category'] ?? ''),
                                      subtitle: Text(transaction['description'] ?? ''),
                                      trailing: Text(
                                        '\$${transaction['amount']}',
                                        style: TextStyle(color: amountColor,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellowAccent.shade200,
        child: const Icon(Iconsax.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Iconsax.money_send, color: Colors.red),
                      title: const Text('Add Expenses'),
                      onTap: () {
                        // Navigate to AddExpenseScreen with title 'Expenses'
                        Get.to(() => AddExpenseScreen(
                          title: 'Expenses',
                          onTap: () {
                            controller.saveExpenseData(
                                controller.selectedOption.value.toString(), 'expense');
                            Get.back(); // Close the modal bottom sheet after saving expense
                          },
                        ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Iconsax.money_recive, color: Colors.green),
                      title: const Text('Add income'),
                      onTap: () {
                        // Navigate to AddExpenseScreen with title 'Income'
                        Get.to(() => AddExpenseScreen(
                          title: 'Income',
                          onTap: () {
                            controller.saveExpenseData(
                                controller.selectedOption.value.toString(), 'income');
                            Get.back(); // Close the modal bottom sheet after saving income
                          },
                        ));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
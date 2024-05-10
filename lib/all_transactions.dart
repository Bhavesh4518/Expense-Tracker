import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/controllers/expenses_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ExpenseController.instance;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'All Transactions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('expenses')
                .orderBy('timestamp',
                descending: false) // Sort by t
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              var transactions = snapshot.data!.docs;
              transactions = transactions.reversed.toList();


              return ListView.separated(
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.yellow.shade50,
                      ),
                      child: ListTile(
                        leading: Icon(icon),
                        title: Text(transaction['category'] ?? ''),
                        subtitle: Text(transaction['description'] ?? ''),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '\$${transaction['amount']}',
                              style: TextStyle(color: amountColor,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${transaction['wallet']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }, separatorBuilder: (_, __) => const SizedBox(height: 8,),
              );
            }),
      )
    );
  }
}

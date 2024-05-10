
import 'package:expense_tracker/common/widgets/my_curved_edged_widget.dart';
import 'package:expense_tracker/controllers/expenses_controller.dart';
import 'package:expense_tracker/my_validation.dart';
import 'package:expense_tracker/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';


class AddExpenseScreen extends StatelessWidget {
   const AddExpenseScreen({super.key,required this.title, this.onTap});

  final String title;
  final void Function()? onTap;


   @override
  Widget build(BuildContext context) {
     final controller = Get.put(ExpenseController());
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              onTap!();
              controller.expense.clear();
              controller.selectedOption.value = 'Other';
              controller.wallet.clear();
              controller.des.clear();
              Get.offAll(() => NavigationMenu());
            },child: const Text('Continue'),),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyCurvedEdgeWidget(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight * 1.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     IconButton(
                     icon : Icon(Icons.keyboard_backspace,
                      color: Colors.white,), onPressed : () => Get.back(),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 23),
                    ),
                    const SizedBox(
                      width: 25,
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                Container(
                    padding: const EdgeInsets.all(23),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How Much ? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                  Theme(
                    data: ThemeData(
                      // Create a new text theme with the desired style for the TextFormField
                      textTheme: const TextTheme(
                        // You can adjust the style of the input text here
                        // For example, change the color to black and set the font size to 18
                        titleMedium: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: TextFormField(
                        controller: controller.expense,
                        validator: (value) => MyValidations.validateEmptyText('\$0', value),
                        style: const TextStyle(color: Colors.white, fontSize: 39, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          hintText: '\$0',
                          hintStyle: TextStyle(color: Colors.white, fontSize: 39, fontWeight: FontWeight.bold),
                          border: InputBorder.none, // Hide the line
                        ),
                      ),
                    ),
                  )
        
                  ],
                    )),
              ],
            )),
            Container(
              padding: const EdgeInsets.only(top: 12, left: 24,right: 24),
                child: Column(
                  children: [
                Container(
                  width : MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child:  Obx(() => DropdownButton<String>(
                hint: const Text("Category"),
                    isExpanded: true,

                value: controller.selectedOption.value,
                onChanged: controller.onDropdownChanged,
                items: <String>['Other','Shopping' ,'Food', 'Travel', 'Subscription','bonus','salary','profit']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
            ),


                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: controller.des,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                          hintStyle : TextStyle(color:Colors.grey)
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: controller.wallet,
                      decoration: const InputDecoration(
                        hintText: 'Enter Wallet',
                        hintStyle: TextStyle(color:Colors.grey)
                      ),
                    ),
                    SizedBox(height: 18,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Iconsax.notification5,size: 15,color: Colors.grey,),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'Your account could be in negative account balance if your expenses are greater than income. This is a simulated account and not a real one.',
                            overflow: TextOverflow.visible,
                            style: TextStyle(color: Colors.grey,fontSize: 12),
                          ),
                        ),
                      ],
                    )

                  ],
                )),
          ],
        ),
      ),
    );
  }
}

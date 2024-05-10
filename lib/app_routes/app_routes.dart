
import 'package:expense_tracker/Main_screens/profile_screen.dart';
import 'package:expense_tracker/all_transactions.dart';
import 'package:expense_tracker/expense/add_expense_screen.dart';
import 'package:get/get.dart';

import '../Main_screens/Home_screen/home_screen.dart';

class AppRoutes {
  static List<GetPage> pages() {

    return [
      GetPage(name: MyRoutes.home, page: () =>  HomeScreen()),
      GetPage(name: MyRoutes.allTransactions, page: () => const AllTransactionsScreen()),
      GetPage(name: MyRoutes.profile, page: () => const MyProfileScreen()),
      GetPage(name: MyRoutes.addExpenseScreen, page: () => const AddExpenseScreen(title: '')),
    ];
  }
}

class MyRoutes {
  static const home = '/home';
  static const allTransactions = '/allTransactions';
  static const profile = '/profile';
  static const addExpenseScreen = '/AddExpenseScreen';

}

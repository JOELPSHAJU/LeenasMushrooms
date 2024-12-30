import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/call_details_screen/call_details_screen.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/daily_data_screen/daily_data_screen.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/income_expense_screen/income_expense_screen.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/order_details_screen/order_details_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  final List<Widget> pages = [
    const DailyDataScreen(),
    const CallDetailsScreen(),
    const OrderDetailsScreen(),
    const IncomeExpenseScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // drawer: UserDrawer(),
        extendBody: true,

        body: ValueListenableBuilder<int>(
          valueListenable: _currentIndexNotifier,
          builder: (context, currentIndex, child) {
            return pages[currentIndex];
          },
        ),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              horizontal: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GNav(
              gap: 8,
              color: Colors.black,
              tabBackgroundColor: AppColors.primaryColor,
              activeColor: Colors.white,
              padding: const EdgeInsets.all(10),
              onTabChange: (value) {
                _currentIndexNotifier.value = value;
              },
              tabs: const [
                GButton(
                  icon: Icons.data_saver_on,
                  text: 'Daily Data',
                ),
                GButton(
                  icon: Icons.add_call,
                  text: 'Call Details',
                ),
                GButton(
                  icon: Icons.view_list,
                  text: 'Order Details',
                ),
                GButton(
                  icon: Icons.attach_money_rounded,
                  text: 'Inc/Exp',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/person_details_widget.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/order_details_screen/complete_order_details_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isWithGST = true;
  String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

  // Example data list
  List<Map<String, String>> orders = [
    {
      'name': 'Rajesh',
      'phone': '+91 1234567890',
      'quantity': '25 kg',
      'trackingId': '#78465747',
      'date': '12 November 2024',
    },
    {
      'name': 'Lokesh',
      'phone': '+91 9876543210',
      'quantity': '15 kg',
      'trackingId': '#78465748',
      'date': '14 November 2024',
    },
    {
      'name': 'Kevin',
      'phone': '+91 1234567890',
      'quantity': '25 kg',
      'trackingId': '#78465747',
      'date': '12 November 2024',
    },
    {
      'name': 'Alex',
      'phone': '+91 1234567890',
      'quantity': '25 kg',
      'trackingId': '#78465747',
      'date': '12 November 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const CommonAppBar(iconNeeded: false),
      body: Column(
        children: [
          ScreenRouteTitle(title: 'Order Details'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.white,
                ),
                height: 55,
                width: size.width * 0.8, // Adjust width dynamically
                child: Row(
                  children: [
                    // With GST Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isWithGST = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color:
                                isWithGST ? AppColors.black : AppColors.white,
                          ),
                          height: 55,
                          child: Center(
                            child: Text(
                              'With GST',
                              style: TextStyle(
                                color: isWithGST
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Without GST Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isWithGST = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color:
                                !isWithGST ? AppColors.black : AppColors.white,
                          ),
                          height: 55,
                          child: Center(
                            child: Text(
                              'Without GST',
                              style: TextStyle(
                                color: !isWithGST
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Content for tabs
          Expanded(
            child: Container(
              color: AppColors.white,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length, // Dynamic list length
                itemBuilder: (context, index) {
                  // Get the order data
                  final order = orders[index];

                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16), // Spacing between cards
                    child: PersonDetailsWidget(
                      name: order['name']!,
                      phoneNumber: order['phone']!,
                      purpose:
                          isWithGST ? 'Order With GST' : 'Order Without GST',
                      status: '', // You can add status data here if needed
                      date: order['date']!,
                      subHedone: 'Quantity',
                      subHedoneData: order['quantity']!,
                      subHedTwo: 'Tracking id',
                      subHedTwoData: order['trackingId']!,
                      isviewed:
                          true, // This can be set dynamically based on order status
                      viewOnPressed: () {
                        // Show alert dialog using the custom widget
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (c) => CompleteOrderDetailScreen(
                                  index: index,
                                )));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

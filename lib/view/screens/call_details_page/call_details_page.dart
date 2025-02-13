import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/person_details_widget.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/view/screens/profile/profile_page.dart';

class CallDetailsPage extends StatefulWidget {
  const CallDetailsPage({super.key});

  @override
  State<CallDetailsPage> createState() => _CallDetailsPageState();
}

class _CallDetailsPageState extends State<CallDetailsPage> {
  String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

  // Example data list
  List<Map<String, String>> orders = [
    {
      'name': 'Kumar',
      'phone': '+91 1234567890',
      'quantity': '25 kg',
      'trackingId': '#78465747',
      'date': '12 November 2024',
    },
    {
      'name': 'Sebastian',
      'phone': '+91 9876543210',
      'quantity': '15 kg',
      'trackingId': '#78465748',
      'date': '14 November 2024',
    },
    {
      'name': 'Mathews',
      'phone': '+91 9876543210',
      'quantity': '15 kg',
      'trackingId': '#78465748',
      'date': '14 November 2024',
    },
    {
      'name': 'Rajesh',
      'phone': '+91 9876543210',
      'quantity': '15 kg',
      'trackingId': '#78465748',
      'date': '14 November 2024',
    },
    {
      'name': 'Linu',
      'phone': '+91 9876543210',
      'quantity': '15 kg',
      'trackingId': '#78465748',
      'date': '14 November 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const CommonAppBar(iconNeeded: false),
      body: Column(
        children: [
          ScreenRouteTitle(title: 'Call Details'),
          const SizedBox(height: 20),
          // Content displaying the list of orders
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
                      child: PersonDetailsWidget(
                        isviewed: false,
                        name: order['name']!,
                        phoneNumber: order['phone']!,
                        purpose: 'Order Details', // Simplified purpose
                        status: '', // You can add status data here if needed
                        date: order['date']!,
                        subHedone: 'Quantity',
                        subHedoneData: order['quantity']!,
                        subHedTwo: 'Tracking id',
                        subHedTwoData: order['trackingId']!,
                        // This can be set dynamically based on order status

                        viewOnPressed: () {},
                      ),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/person_details_widget.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool isWithGST = true; // Tab selection state
  String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

  // Example data list
  List<Map<String, String>> orders = [
    {
      'name': 'Mujthaba',
      'phone': '+91 1234567890',
      'quantity': '25 kg',
      'trackingId': '#78465747',
      'date': '12 November 2024',
    },
    {
      'name': 'Ali',
      'phone': '+91 9876543210',
      'quantity': '15 kg',
      'trackingId': '#78465748',
      'date': '14 November 2024',
    },
    // Add more orders here as needed
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: AppColors.black),
        centerTitle: true,
        title: loadAssetPic(ImagePathProvider.logoletters, height: 40),
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      body: Column(
        children: [
          h30,
          // Tab Bar for With/Without GST
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
                      purpose: isWithGST
                          ? 'Order With GST'
                          : 'Order Without GST', // Update dynamically
                      status: '', // You can add status data here if needed
                      date: order['date']!,
                      subHedone: 'Quantity',
                      subHedoneData: order['quantity']!,
                      subHedTwo: 'Tracking id',
                      subHedTwoData: order['trackingId']!,
                      isviewed:
                          true, // This can be set dynamically based on order status
                      viewOnPressed: () {
                        // Handle view button action
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

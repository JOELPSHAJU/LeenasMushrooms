import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/person_details_widget.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.white,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.h,
                      color: AppColors.black,
                    ),
                  ),
                ),
                w10,
                Text(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  'Order Details ',
                  style: AppFonts.getAppFont(
                      context: context,
                      color: AppColors.black,
                      weight: FontWeight.w500,
                      size: 21.sp),
                ),
              ],
            ),
          ),

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

                      viewOnPressed: () {
                        // Show alert dialog using the custom widget
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

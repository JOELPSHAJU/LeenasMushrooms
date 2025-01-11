import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/person_details_widget.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class OrderDetailsDialog extends StatelessWidget {
  final Map<String, String> order;

  const OrderDetailsDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        width: size.width * 0.9, // Adjust width dynamically
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              context,
              label: 'Name',
              value: order['name'] ?? 'N/A',
            ),
            const Divider(thickness: 0.5, color: Colors.grey),
            _buildDetailRow(
              context,
              label: 'Phone',
              value: order['phone'] ?? 'N/A',
            ),
            const Divider(thickness: 0.5, color: Colors.grey),
            _buildDetailRow(
              context,
              label: 'Item',
              value: 'Mushroom',
            ),
            const Divider(thickness: 0.5, color: Colors.grey),
            _buildDetailRow(
              context,
              label: 'Quantity',
              value: '44',
            ),
            const Divider(thickness: 0.5, color: Colors.grey),
            _buildDetailRow(
              context,
              label: 'Pin Code',
              value: '66666',
            ),
            const Divider(thickness: 0.5, color: Colors.grey),
            _buildDetailRow(
              context,
              label: 'Adress',
              value:
                  'Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016',
            ),
            const Divider(thickness: 0.5, color: Colors.grey),
            _buildDetailRow(
              context,
              label: 'Courier data',
              value: 'data',
            ),
            const Divider(thickness: 0.5, color: Colors.grey),
            _buildDetailRow(
              context,
              label: 'Tracking ID',
              value: order['trackingId'] ?? 'N/A',
            ),
            const Divider(thickness: 0.5, color: Colors.grey),
            _buildDetailRow(
              context,
              label: 'Payment Status',
              value: "Paid",
            ),
          ],
        ),
      ),
    );
  }

  /// Helper function to build a standardized row for each detail
  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 6.0), // Spacing between rows
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Container for Label
          Container(
            width: MediaQuery.of(context).size.width * 0.3, // Label width
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: AppFonts.getAppFont(
                context: context,
                color: Colors.black,
                weight: FontWeight.w400,
                size: 18.0, // Adjust font size as needed
              ),
            ),
          ),

          const Text(":"),
          const SizedBox(width: 8), // Spacing between colon and value

          /// Container for Value
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: AppFonts.getAppFont(
                    context: context,
                    color: Colors.black,
                    weight: FontWeight.w400,
                    size: 18.0, // Adjust font size as needed
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  bool isWithGST = true;
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

  /// Show dialog method
  void showOrderDetailsDialog(BuildContext context, Map<String, String> order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OrderDetailsDialog(order: order);
      },
    );
  }

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
                        showOrderDetailsDialog(context, order);
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

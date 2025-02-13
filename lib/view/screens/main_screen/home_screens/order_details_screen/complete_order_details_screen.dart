import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class CompleteOrderDetailScreen extends StatefulWidget {
  final int index;
  const CompleteOrderDetailScreen({super.key, required this.index});

  @override
  State<CompleteOrderDetailScreen> createState() =>
      _CompleteOrderDetailScreenState();
}

class _CompleteOrderDetailScreenState extends State<CompleteOrderDetailScreen> {
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
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        context,
                        label: 'Name',
                        value: orders[widget.index]['name'] ?? 'N/A',
                      ),
                      const Divider(thickness: 0.5, color: Colors.grey),
                      _buildDetailRow(
                        context,
                        label: 'Phone',
                        value: orders[widget.index]['phone'] ?? 'N/A',
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
                        value: orders[widget.index]['trackingId'] ?? 'N/A',
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
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildDetailRow(
  BuildContext context, {
  required String label,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: AppFonts.getAppFont(
              context: context,
              color: Colors.black,
              weight: FontWeight.w400,
              size: 18.0,
            ),
          ),
        ),
        const Text(":"),
        const SizedBox(width: 8),
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
                  size: 18.0,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

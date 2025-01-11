import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/common_widgets/scrolleble_data_table.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';

class IncomeDetailPage extends StatelessWidget {
  const IncomeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example column labels
    final List<String> columnLabels = [
      'Date',
      'User Details',
      'Source',
      'Amount'
    ];

    // Example row data
    final List<List<String>> rowData = [
      ['1/12/2024', 'User 1', ' ', '34000'],
      ['2/12/2024', 'User 2', '', '25000'],
      // Add more rows as needed
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: AppColors.black),
        centerTitle: true,
        title: loadAssetPic(ImagePathProvider.logoletters, height: 40),
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Income Details',
                  style: AppFonts.getAppFont(
                    context: context,
                    size: 21,
                    weight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ScrollableTable(
              columnLabels: columnLabels,
              rowData: rowData,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/common_widgets/scrolleble_data_table.dart';

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
      ['3/12/2024', 'User 3', ' ', '34000'],
      ['4/12/2024', 'User 4', '', '25000'],
      ['5/12/2024', 'User 5', ' ', '34000'],
      ['6/12/2024', 'User 6', '', '25000'],
      ['7/12/2024', 'User 7', ' ', '34000'],
      ['8/12/2024', 'User 8', '', '25000'],
      ['9/12/2024', 'User 9', ' ', '34000'],
      ['10/12/2024', 'User 10', '', '25000'],
      ['11/12/2024', 'User 11', ' ', '34000'],
      ['12/12/2024', 'User 12', '', '25000'],
      ['13/12/2024', 'User 13', ' ', '34000'],
      ['14/12/2024', 'User 14', '', '25000'],
      // Add more rows as needed
    ];

    return Scaffold(
      appBar: const CommonAppBar(iconNeeded: false),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
           ScreenRouteTitle(title: 'Income Details'),
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

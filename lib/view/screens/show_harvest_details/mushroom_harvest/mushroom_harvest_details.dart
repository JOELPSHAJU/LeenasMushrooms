import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/harvest_data_table.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';

class MushroomHarvestDetails extends StatelessWidget {
  const MushroomHarvestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> columnLabels = [
      'Date',
      'Harvesting Time',
      'Quantity',
      'Damage',
      'Remarks',
    ];

    final List<List<String>> rowData = [
      ['1/12/2024', 'Morning', '16kg', '2kg', 'No issues'],
      ['2/12/2024', 'Evening', '16kg', '2kg', 'Handled carefully'],
      ['3/12/2024', 'Morning', '16kg', '5g', 'No issues'],
      ['4/12/2024', 'Evening', '16kg', '2kg', 'Handled carefully'],
      ['5/12/2024', 'Morning', '16kg', '2kg', 'No issues'],
      ['6/12/2024', 'Evening', '16kg', '6kg', 'Handled carefully'],
      ['7/12/2024', 'Morning', '16kg', '2kg', 'No issues'],
      ['8/12/2024', 'Evening', '16kg', '24kg', 'Handled carefully'],
      ['9/12/2024', 'Morning', '16kg', '2kg', 'No issues'],
      ['10/12/2024', 'Evening', '16kg', '2kg', 'Handled carefully'],
      ['11/12/2024', 'Morning', '16kg', '2kg', 'No issues'],
      ['12/12/2024', 'Evening', '16kg', '2kg', 'Handled carefully'],
      ['13/12/2024', 'Morning', '16kg', '2kg', 'No issues'],
      ['14/12/2024', 'Evening', '16kg', '2kg', 'Handled carefully'],
      ['15/12/2024', 'Morning', '16kg', '2kg', 'No issues'],
      ['16/12/2024', 'Evening', '16kg', '2kg', 'Handled carefully'],
      ['17/12/2024', 'Morning', '16kg', '2kg', 'No issues'],
      ['18/12/2024', 'Evening', '16kg', '2kg', 'Handled carefully'],
    ];

    return Scaffold(
      appBar: const CommonAppBar(iconNeeded: false),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          ScreenRouteTitle(title: 'Mushroom Harvest Details'),
          Expanded(
            child: HarvestDataTable(
              columnLabels: columnLabels,
              rowData: rowData,
            ),
          ),
        ],
      ),
    );
  }
}

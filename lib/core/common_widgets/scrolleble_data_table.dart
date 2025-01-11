import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';

class ScrollableTable extends StatelessWidget {
  final List<String> columnLabels;
  final List<List<String>> rowData;

  const ScrollableTable({
    super.key,
    required this.columnLabels,
    required this.rowData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      color: Colors.white, // Ensures the table background is pure white
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: screenWidth),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(Colors.white),
            dataRowColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                return states.contains(WidgetState.selected)
                    ? Colors.grey.shade200
                    : null;
              },
            ),
            columnSpacing: 16,
            dividerThickness: 0, // Removes borders between rows
            headingTextStyle: AppFonts.getAppFont(
              context: context,
              size: 16,
              weight: FontWeight.bold,
              color: Colors.black,
            ),
            dataTextStyle: AppFonts.getAppFont(
              context: context,
              size: 14,
              color: Colors.black,
            ),
            columns: columnLabels
                .map((label) => DataColumn(
                      label: Center(
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ))
                .toList(),
            rows: rowData.asMap().entries.map((entry) {
              int index = entry.key;
              List<String> row = entry.value;

              return DataRow(
                color: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return index.isEven
                        ? Colors.white
                        : const Color(0xFFF0F0F0);
                  },
                ),
                cells: row.map((cell) => _buildDataCell(cell)).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Common widget to handle text inside DataCell
  DataCell _buildDataCell(String text) {
    return DataCell(
      Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: BarChartExample(),
      ),
    );
  }
}

class BarChartExample extends StatefulWidget {
  const BarChartExample({super.key});

  @override
  State<BarChartExample> createState() => _BarChartExampleState();
}

class _BarChartExampleState extends State<BarChartExample> {
  late List<ChartData> _chartData;
  late List<ChartData> _filteredData;
  Set<String> selectedCategories = {}; // Keep track of selected categories

  @override
  void initState() {
    _chartData = getChartData();
    _filteredData = _chartData;
    super.initState();
  }

  List<ChartData> getChartData() {
    return [
      ChartData('Jan', 50, 80, 60),
      ChartData('Feb', 80, 100, 90),
      ChartData('Mar', 60, 75, 70),
      ChartData('Apr', 50, 85, 65),
      ChartData('May', 75, 100, 90),
      ChartData('Jun', 50, 100, 80),
      ChartData('Jul', 60, 90, 75),
      ChartData('Aug', 70, 85, 80),
      ChartData('Sep', 80, 95, 85),
      ChartData('Oct', 65, 100, 95),
      ChartData('Nov', 75, 85, 80),
      ChartData('Dec', 90, 110, 100),
    ];
  }

  void updateChartData(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }

      _filteredData = _chartData.map((data) {
        double value1 = 0, value2 = 0, value3 = 0;

        if (selectedCategories.contains('Mashroom')) {
          value1 = data.value1;
        }
        if (selectedCategories.contains('Bed')) {
          value2 = data.value2;
        }
        if (selectedCategories.contains('Seed')) {
          value3 = data.value3;
        }

        return ChartData(data.month, value1, value2, value3);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          width: screenWidth, // Full width for horizontal scrolling
          height: 300, // Adjusted height for better appearance
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelRotation:
                  -45, // Rotates the x-axis labels for better readability
            ),
            primaryYAxis: const NumericAxis(
              minimum: 0,
              maximum: 120,
              interval: 20,
              majorGridLines: MajorGridLines(width: 0),
            ),
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true, // Enable horizontal panning
              zoomMode: ZoomMode.x, // Allow horizontal zooming
              enablePinching: true, // Optional: Enables pinch-to-zoom
            ),
            series: [
              ColumnSeries<ChartData, String>(
                dataSource: _filteredData,
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value1,
                color: Colors.black87,
                width: 0.3,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15)), // Rounded top corners
              ),
              ColumnSeries<ChartData, String>(
                dataSource: _filteredData,
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value2,
                color: Colors.cyan,
                width: 0.3,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15)), // Rounded top corners
              ),
              ColumnSeries<ChartData, String>(
                dataSource: _filteredData,
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value3,
                color: Colors.orange,
                width: 0.3,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15)), // Rounded top corners
              ),
            ],
          ),
        ),
        // Color Identification Section
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => updateChartData('Mashroom'),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.black87, // Bed color
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Mashroom'),
                ],
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => updateChartData('Bed'),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.cyan, // Bed color
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Bed'),
                ],
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => updateChartData('Seed'),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Seed'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartData {
  final String month;
  final double value1;
  final double value2;
  final double value3;

  ChartData(this.month, this.value1, this.value2, this.value3);
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartMainScreen extends StatefulWidget {
  const BarChartMainScreen({super.key});

  @override
  State<BarChartMainScreen> createState() => _BarChartMainScreenState();
}

class _BarChartMainScreenState extends State<BarChartMainScreen> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // Added padding for better spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: SfCartesianChart(
        borderWidth: 0,
        tooltipBehavior: _tooltip,
        legend: const Legend(isVisible: true),
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            name: 'Mushroom',
            dataSource: chartData,
            color: Colors.teal,
            spacing: 0.2, // Added spacing between bars
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y1,
          ),
          ColumnSeries<ChartData, String>(
            name: 'Bed',
            dataSource: chartData,
            color: Colors.orange,
            spacing: 0.2, // Consistent spacing
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y2,
          ),
          ColumnSeries<ChartData, String>(
            name: 'Seed',
            dataSource: chartData,
            color: Colors.blue,
            spacing: 0.2, // Ensuring equal spacing
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y3,
          ),
        ],
      ),
    );
  }

  final List<ChartData> chartData = [
    ChartData("Jan", 35, 28, 22),
    ChartData("Feb", 40, 32, 25),
    ChartData("Mar", 30, 27, 20),
    ChartData("Apr", 45, 38, 30),
    ChartData("May", 50, 42, 35),
  ];
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3);
  final String x;
  final double y1;
  final double y2;
  final double y3;
}

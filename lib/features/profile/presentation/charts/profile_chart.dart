import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProfileChart extends StatelessWidget {
  final List<double> performanceScores; // Example: monthly performance values

  const ProfileChart({Key? key, required this.performanceScores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('M${value.toInt() + 1}'); // Month label
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: performanceScores
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value))
                .toList(),
            isCurved: true,
            barWidth: 3,
            color: Colors.purple,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}

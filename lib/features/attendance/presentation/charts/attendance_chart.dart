import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AttendanceChart extends StatelessWidget {
  final List<int> weeklyAttendance; // Example: [1,0,1,1,0,1,1] → 1=present,0=absent

  const AttendanceChart({Key? key, required this.weeklyAttendance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 1,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                return Text(days[value.toInt()]);
              },
            ),
          ),
        ),
        barGroups: List.generate(
          weeklyAttendance.length,
              (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: weeklyAttendance[index].toDouble(),
                color: weeklyAttendance[index] == 1 ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

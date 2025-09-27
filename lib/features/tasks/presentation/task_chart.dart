import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:workforce_management_app/features/tasks/domain/entities/task.dart';

class TaskChart extends StatelessWidget {
  final Map<TaskStatus, int> taskCounts;

  const TaskChart({Key? key, required this.taskCounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = taskCounts.values.fold<int>(0, (a, b) => a + b);

    return PieChart(
      PieChartData(
        sections: taskCounts.entries.map((entry) {
          final percentage = total == 0 ? 0 : (entry.value / total * 100);
          return PieChartSectionData(
            value: entry.value.toDouble(),
            title: "${percentage.toStringAsFixed(1)}%",
            color: _getColor(entry.key),
            radius: 60,
          );
        }).toList(),
      ),
    );
  }


  Color _getColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return Colors.blue;
      case TaskStatus.inProgress:
        return Colors.orange;
      case TaskStatus.done:
        return Colors.green;
    }
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StepChart extends StatelessWidget {
  final List<int> steps;

  StepChart({required this.steps});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: steps.length.toDouble(),
        minY: 0,
        maxY: steps.isNotEmpty ? steps.reduce((a, b) => a > b ? a : b).toDouble() : 100,
        lineBarsData: [
          LineChartBarData(
            spots: steps.asMap().entries.map((entry) {
              int index = entry.key;
              int value = entry.value;
              return FlSpot(index.toDouble(), value.toDouble());
            }).toList(),
            isCurved: true,
            color: Colors.blue,
            belowBarData: BarAreaData(show: true, color:Colors.blue.withOpacity(0.3)),
          ),
        ],
      ),
    );
  }
}

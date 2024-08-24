import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'step_data_storage.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Steps History')),
      body: Column(
        children: <Widget>[
          Expanded(child: StepsProgressChart()),
        ],
      ),
    );
  }
}

class StepsProgressChart extends StatelessWidget {
  final bool animate;

  StepsProgressChart({this.animate = true});

  Future<List<charts.Series<StepsData, int>>> _loadStepData() async {
    final stepsDataMap = await StepDataStorage.getAllSteps();
    final data = stepsDataMap.entries.map((entry) => StepsData(entry.key, entry.value)).toList();

    return [
      charts.Series<StepsData, int>(
        id: 'Steps',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (StepsData steps, _) => steps.day,
        measureFn: (StepsData steps, _) => steps.steps,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<charts.Series<StepsData, int>>>(
      future: _loadStepData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return charts.LineChart(
            snapshot.data!,
            animate: animate,
          );
        } else {
          return Center(child: Text("No step data available"));
        }
      },
    );
  }
}

class StepsData {
  final int day;
  final int steps;

  StepsData(this.day, this.steps);
}

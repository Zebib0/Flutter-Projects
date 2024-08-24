import 'package:flutter/material.dart';

class WeatherPrediction extends StatelessWidget {
  final String cityName;

  WeatherPrediction({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Weather prediction for $cityName (Coming Soon)',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

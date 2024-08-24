import 'package:flutter/material.dart';

class WeatherChart extends StatelessWidget {
  final String cityName;

  WeatherChart({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Chart for $cityName (Coming Soon)',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

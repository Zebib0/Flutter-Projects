import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepCounterWidget extends StatefulWidget {
  @override
  _StepCounterWidgetState createState() => _StepCounterWidgetState();
}

class _StepCounterWidgetState extends State<StepCounterWidget> {
  StreamSubscription<StepCount>? _stepCountSubscription;
  int _steps = 0;
  bool _isTracking = false;
  double _distanceInKm = 0;
  double _caloriesBurnt = 0;
  double _hoursWalked = 0;
  DateTime? _startTime;

  final double _stepLengthInMeters = 0.78; // Average step length in meters
  final double _caloriesPerKm = 70; // Average calories burnt per kilometer

  @override
  void initState() {
    super.initState();
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
      _steps = 0;
      _distanceInKm = 0;
      _caloriesBurnt = 0;
      _hoursWalked = 0;
      _startTime = DateTime.now();
    });

    _stepCountSubscription = Pedometer.stepCountStream.listen((event) {
      if (_isTracking) {
        setState(() {
          _steps = event.steps;
          _distanceInKm = (_steps * _stepLengthInMeters) / 1000;
          _caloriesBurnt = _distanceInKm * _caloriesPerKm;
          if (_startTime != null) {
            _hoursWalked = DateTime.now().difference(_startTime!).inMinutes / 60;
          }
        });
      }
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
    _stepCountSubscription?.cancel(); // Stop listening to the stream
  }

  @override
  void dispose() {
    _stepCountSubscription?.cancel(); // Clean up subscription on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(30),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Steps: $_steps',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'IndieFlower',
            fontSize: 50,
          )),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Icon(Icons.fireplace),
                Text(': ${_caloriesBurnt.toStringAsFixed(2)} kcal',
                    style: TextStyle(
                      fontFamily: 'IndieFlower',
                    )),
                SizedBox(
                  child: Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0) ,),
                ),
                Icon(Icons.watch),
                Text(': ${_hoursWalked.toStringAsFixed(2)} hrs',
                    style: TextStyle(
                      fontFamily: 'IndieFlower',
                    )),
              ],
            ),
          ),
          Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 20),
           child: Row(
              children: [
                Icon(Icons.electric_meter),
                Text('Distance: ${_distanceInKm.toStringAsFixed(2)} km',
                    style: TextStyle(
                      fontFamily: 'IndieFlower',
                    )),
              ],
            ),

          ),),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isTracking ? null : _startTracking,
            child: Text('Start Tracking',
                style: TextStyle(
                  fontFamily: 'IndieFlower',
                )),
          ),
          ElevatedButton(
            onPressed: !_isTracking ? null : _stopTracking,
            child: Text('Stop Tracking',
                style: TextStyle(
                  fontFamily: 'IndieFlower',
                  color: Colors.indigo[200]
                )),
          ),
        ],
      ),),
    );
  }
}

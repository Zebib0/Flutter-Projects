import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _nickNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  final _targetStepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Setup')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nickNameController,
                decoration: InputDecoration(labelText: 'Nickname'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _targetWeightController,
                decoration: InputDecoration(labelText: 'Target Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _targetStepsController,
                decoration: InputDecoration(labelText: 'Target Steps Per Day'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('nickName', _nickNameController.text);
                  prefs.setInt('age', int.parse(_ageController.text));
                  prefs.setInt('height', int.parse(_heightController.text));
                  prefs.setInt('weight', int.parse(_weightController.text));
                  prefs.setInt('targetWeight', int.parse(_targetWeightController.text));
                  prefs.setInt('targerSteps', int.parse(_targetStepsController.text));

                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pedometer_app/service.dart';
import 'dark_mode.dart';
import 'package:pedometer_app/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<String> _routes = [
    '/steps',
    '/history',
    '/setup',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, _routes[index]);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            DarkModeToggle(), // Add the dark mode toggle here
          ],
        title: Text('Pedometer',
        style: TextStyle(
        fontFamily: 'IndieFlower',
    ),),
    centerTitle: true,
    backgroundColor: Colors.indigo[200],
    ),
    body: Column(
    children: <Widget>[
    // Pedometer Counter and Stats
    Expanded(child: StepCounterWidget()),

    ],
    ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
    );
  }
}



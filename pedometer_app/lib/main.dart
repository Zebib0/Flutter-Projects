import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'service.dart';
import 'history.dart';
import 'setup_screen.dart';
import 'theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  void _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    });
    if (_isFirstLaunch) {
      // Set first launch to false after showing the SetupInfoPage
      prefs.setBool('isFirstLaunch', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Pedometer App',
            initialRoute: _isFirstLaunch ? '/setup' : '/',
            routes: {
              '/': (context) => HomePage(),
              '/steps': (context) => StepCounterWidget(),
              '/history': (context) => HistoryPage(),
              '/setup': (context) => SetupScreen(),
              // Ensure this is editable for new users
            },
          );
        }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

class DarkModeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return Switch(
          value: themeNotifier.isDarkMode,
          onChanged: (value) {
            themeNotifier.toggleTheme();
          },
          activeColor: Colors.black, // Color of the switch thumb when it is on
          inactiveThumbColor: Colors.white, // Color of the switch thumb when it is off
          inactiveTrackColor: Colors.grey, // Color of the track when the switch is off
          activeTrackColor: Colors.black.withOpacity(0.3), // Color of the track when the switch is on
        );
      },
    );
  }
}

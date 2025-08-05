import 'package:flutter/material.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'theme.dart'; // Import the theme extensions

class LanguageLearningScreen extends StatelessWidget {
  final bool isChildModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;
  final bool isDarkModeActive;

  LanguageLearningScreen({
    this.isChildModeActive = false,
    required this.toggleDarkMode,
    required this.toggleChildMode,
    required this.isDarkModeActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        onDarkModeToggle: () => toggleDarkMode(!isDarkModeActive),
        onLanguageChange: () {
          // Handle language change
        },
        onChildModeToggle: () => toggleChildMode(!isChildModeActive),
        isChildModeActive: isChildModeActive,
      ),
      drawer: CustomDrawer(
        onDarkModeToggle: () => toggleDarkMode(!isDarkModeActive),
        onLanguageChange: () {
          // Handle language change
        },
        onChildModeToggle: () => toggleChildMode(!isChildModeActive),
        isChildModeActive: isChildModeActive,
        isDarkModeActive: isDarkModeActive,
        onDarkModeChanged: (bool value) {
          toggleDarkMode(value);
        },
        onChildModeChanged: (bool value) {
          toggleChildMode(value);
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkModeActive
              ? theme.customThemeData.darkSecondaryGradient
              : theme.customThemeData.lightSecondaryGradient,
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              gradient: isDarkModeActive
                  ? theme.customThemeData.darkModeContainerGradient
                  : theme.customThemeData.lightSecondaryGradient,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Language Learning',
                  style: theme.textTheme.displayLarge,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Your action for Language 1
                  },
                  child: Text('Language 1'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Your action for Language 2
                  },
                  child: Text('Language 2'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Your action for Language 3
                  },
                  child: Text('Language 3'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

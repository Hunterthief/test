import 'package:flutter/material.dart';
import '/widgets/custom_app_bar.dart'; // Import the custom app bar
import '/widgets/custom_drawer.dart'; // Import the custom drawer
import '/theme.dart'; // Import the theme extensions
import '/Stories/story_1_page.dart'; // Import your story pages
import '/Stories/story_2_page.dart'; // Import your story pages

class StoriesScreen extends StatelessWidget {
  final bool isChildModeActive;
  final bool isDarkModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;

  const StoriesScreen({
    required this.isChildModeActive,
    required this.isDarkModeActive,
    required this.toggleDarkMode,
    required this.toggleChildMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        onDarkModeToggle: () => toggleDarkMode(!isDarkModeActive),
        onLanguageChange: () {}, // Implement if needed
        onChildModeToggle: () => toggleChildMode(!isChildModeActive),
        isChildModeActive: isChildModeActive,
      ),
      drawer: CustomDrawer(
        onDarkModeToggle: () => toggleDarkMode(!isDarkModeActive),
        onLanguageChange: () {}, // Implement if needed
        onChildModeToggle: () => toggleChildMode(!isChildModeActive),
        isChildModeActive: isChildModeActive,
        isDarkModeActive: isDarkModeActive,
        onDarkModeChanged: (value) => toggleDarkMode(value),
        onChildModeChanged: (value) => toggleChildMode(value),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkModeActive
              ? theme.customThemeData.darkPrimaryGradient
              : theme.customThemeData.lightPrimaryGradient,
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
                  'قصص اطفال',
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Story1Page(
                          isChildModeActive: isChildModeActive,
                          isDarkModeActive: isDarkModeActive,
                          toggleDarkMode: toggleDarkMode,
                          toggleChildMode: toggleChildMode,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '🐰 قصة الارنب الكسول',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Story2Page(
                          isChildModeActive: isChildModeActive,
                          isDarkModeActive: isDarkModeActive,
                          toggleDarkMode: toggleDarkMode,
                          toggleChildMode: toggleChildMode,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '🐭 قصة الفأر المغرور',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'theme.dart';
import '../Symptom_guides/stuttering_screen.dart'; // Make sure this import is correct
import '../Symptom_guides/lisping_screen.dart';
import '../Symptom_guides/stuttering_test_screen.dart'; // Import the new screen

class SymptomScreen extends StatelessWidget {
  final bool isChildModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;
  final bool isDarkModeActive;

  SymptomScreen({
    this.isChildModeActive = false,
    required this.toggleDarkMode,
    required this.toggleChildMode,
    required this.isDarkModeActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customTheme = theme.customThemeData;

    return Scaffold(
      appBar: CustomAppBar(
        onDarkModeToggle: () => toggleDarkMode(!isDarkModeActive),
        onLanguageChange: () {},
        onChildModeToggle: () => toggleChildMode(!isChildModeActive),
        isChildModeActive: isChildModeActive,
      ),
      drawer: CustomDrawer(
        onDarkModeToggle: () => toggleDarkMode(!isDarkModeActive),
        onLanguageChange: () {},
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
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(
            gradient: isDarkModeActive
                ? customTheme.darkPrimaryGradient
                : customTheme.lightPrimaryGradient,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'معلومات تهمك',
                style: theme.textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  children: <Widget>[
                    _buildSymptomCard(
                      text: '💬 معلومات عن التلعثم و تحديد مدتها',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StutteringTestScreen(
                              isChildModeActive: isChildModeActive,
                              toggleDarkMode: toggleDarkMode,
                              toggleChildMode: toggleChildMode,
                              isDarkModeActive: isDarkModeActive,
                            ),
                          ),
                        );
                      },
                    ),
                    _buildSymptomCard(
                      text: '👅 اللدغة',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LispingScreen(
                              isChildModeActive: isChildModeActive,
                              toggleDarkMode: toggleDarkMode,
                              toggleChildMode: toggleChildMode,
                              isDarkModeActive: isDarkModeActive,
                            ),
                          ),
                        );
                      },
                    ),
                    _buildSymptomCard(
                      text: '🌟 مقالات',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StutteringScreen(
                              isChildModeActive: isChildModeActive,
                              toggleDarkMode: toggleDarkMode,
                              toggleChildMode: toggleChildMode,
                              isDarkModeActive: isDarkModeActive,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomCard({
    required String text,
    VoidCallback? onTap, // Optional callback for navigation
  }) {
    return GestureDetector(
      onTap: onTap, // Handle tapping the card
      child: Card(
        color: isDarkModeActive
            ? Colors.transparent
            : Colors.white, // Adjust for dark mode
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 8.0), // Adjust padding
            title: Text(
              text,
              style: TextStyle(
                fontSize: 16, // Adjust text size
                fontWeight: FontWeight.bold,
                color: isDarkModeActive ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

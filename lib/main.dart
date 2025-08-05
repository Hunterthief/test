import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'theme.dart';
import 'symptom_screen.dart';
import 'language_learning_screen.dart';
import 'home_screen.dart';
import 'widgets/screens/sign_in_screen.dart';
import 'widgets/screens/sign_up_screen.dart';
import 'widgets/screens/pop_up_screen.dart';
//import 'widgets/custom_drawer.dart';
import 'parent_guide_screen.dart';
import 'Parent_guides/tips_screen.dart';
//import 'video_screen.dart';
import 'stories_screen.dart';
import 'skills_screen.dart';
import 'games_screen.dart'; // Import the GamesScreen

//this used to keep the project from expiring asdadsdasda
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load SharedPreferences and check if the video has been viewed
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenVideo = prefs.getBool('hasSeenVideo') ?? false;

  runApp(MyApp(
    isFirstRun: !hasSeenVideo, // Pass whether it's the first run
  ));
}

class MyApp extends StatefulWidget {
  final bool isFirstRun;

  MyApp({required this.isFirstRun});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkMode = false;
  bool _isChildModeActive = false;

  void _toggleDarkMode(bool value) {
    setState(() {
      _darkMode = value;
    });
  }

  void _toggleChildMode(bool value) {
    setState(() {
      _isChildModeActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoFlu',
      theme: _darkMode ? darkTheme : lightTheme,
      home: /* widget.isFirstRun ? VideoScreen() : */ HomeScreen(
        // Commented out the VideoScreen start logic
        toggleDarkMode: _toggleDarkMode,
        toggleChildMode: _toggleChildMode,
        isChildModeActive: _isChildModeActive,
        isDarkModeActive: _darkMode,
      ),
      routes: {
        '/symptoms': (context) => SymptomScreen(
              isChildModeActive: _isChildModeActive,
              toggleDarkMode: _toggleDarkMode,
              toggleChildMode: _toggleChildMode,
              isDarkModeActive: _darkMode,
            ),
        '/language-learning': (context) => LanguageLearningScreen(
              isChildModeActive: _isChildModeActive,
              toggleDarkMode: _toggleDarkMode,
              toggleChildMode: _toggleChildMode,
              isDarkModeActive: _darkMode,
            ),
        '/parent-guide': (context) => ParentGuideScreen(
              isChildModeActive: _isChildModeActive,
              toggleDarkMode: _toggleDarkMode,
              toggleChildMode: _toggleChildMode,
              isDarkModeActive: _darkMode,
            ),
        '/tips': (context) => TipsScreen(
              isChildModeActive: _isChildModeActive,
              toggleDarkMode: _toggleDarkMode,
              toggleChildMode: _toggleChildMode,
              isDarkModeActive: _darkMode,
            ),
        '/login': (context) => SignInScreen(),
        '/register': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(
              toggleDarkMode: _toggleDarkMode,
              toggleChildMode: _toggleChildMode,
              isChildModeActive: _isChildModeActive,
              isDarkModeActive: _darkMode,
            ),
        '/pop-up': (context) => PopUpScreen(), // Add this line
        '/stories': (context) => StoriesScreen(
              isChildModeActive: _isChildModeActive,
              toggleDarkMode: _toggleDarkMode,
              toggleChildMode: _toggleChildMode,
              isDarkModeActive: _darkMode,
            ),
        '/skills': (context) => SkillsScreen(
              isChildModeActive: _isChildModeActive,
              toggleDarkMode: _toggleDarkMode,
              toggleChildMode: _toggleChildMode,
              isDarkModeActive: _darkMode,
            ), // Add this line
        '/games': (context) => GamesScreen(
              isChildModeActive: _isChildModeActive,
              isDarkModeActive: _darkMode,
              toggleDarkMode: _toggleDarkMode,
              toggleChildMode: _toggleChildMode,
            ), // Add this line for GamesScreen
      },
    );
  }
}

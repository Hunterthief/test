import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart'; // Import the just_audio package
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'theme.dart';
//import 'stories_screen.dart'; // Import the new StoriesScreen
//import 'skills_screen.dart'; // Import the new SkillsScreen

class HomeScreen extends StatefulWidget {
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;
  final bool isChildModeActive;
  final bool isDarkModeActive;

  HomeScreen({
    required this.toggleDarkMode,
    required this.toggleChildMode,
    required this.isChildModeActive,
    required this.isDarkModeActive,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer _player; // Declare the audio player

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer(); // Initialize the audio player
  }

  @override
  void dispose() {
    _player.dispose(); // Dispose the audio player
    super.dispose();
  }

  Future<void> _playButtonSound() async {
    try {
      await _player.setAsset(
          'assets/audio/SFXs/button_sound.mp3'); // Path to your button sound effect
      _player.play();
    } catch (e) {
      print("Error playing button sound: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onDarkModeToggle: () => widget.toggleDarkMode(!widget.isDarkModeActive),
        onLanguageChange: () {
          // Handle language change
        },
        onChildModeToggle: () =>
            widget.toggleChildMode(!widget.isChildModeActive),
        isChildModeActive: widget.isChildModeActive,
      ),
      drawer: CustomDrawer(
        onDarkModeToggle: () => widget.toggleDarkMode(!widget.isDarkModeActive),
        onLanguageChange: () {
          // Handle language change
        },
        onChildModeToggle: () =>
            widget.toggleChildMode(!widget.isChildModeActive),
        isChildModeActive: widget.isChildModeActive,
        isDarkModeActive: widget.isDarkModeActive,
        onDarkModeChanged: (value) => widget.toggleDarkMode(value),
        onChildModeChanged: (value) => widget.toggleChildMode(value),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: widget.isDarkModeActive
              ? darkPrimaryGradient
              : lightPrimaryGradient,
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              gradient: widget.isDarkModeActive
                  ? darkModeContainerGradient
                  : lightSecondaryGradient,
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
                  'SoFlu',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                SizedBox(height: 20),
                _buildButtonRow(context, 'الارشاد الاسري', '/parent-guide'),
                SizedBox(height: 20),
                _buildButtonRow(context, 'تخاطب', '/symptoms'),
                SizedBox(height: 20),
                _buildButtonRow(
                    context, 'تنمية مهارات', '/skills'), // Updated route
                SizedBox(height: 20),
                _buildButtonRow(
                    context, 'تربية بالقصة', '/stories'), // Updated route
                SizedBox(height: 20),
                _buildButtonRow(
                    context, 'ألعاب', '/games'), // Updated route to GamesScreen
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, String text, String? route) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              await _playButtonSound(); // Play button sound
              if (route != null) {
                Navigator.pushNamed(context, route);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.isDarkModeActive
                  ? Colors.blueGrey[700]
                  : Colors.lightBlue[
                      400], // Set the background color based on dark mode
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getButtonTextWithEmoji(text),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white, // Set button text color to white
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getButtonTextWithEmoji(String text) {
    switch (text) {
      case 'الارشاد الاسري':
        return '👨‍👩‍👧‍👦 $text';
      case 'تخاطب':
        return '🗣️ $text';
      case 'تنمية مهارات':
        return '🌟 $text';
      case 'تربية بالقصة':
        return '📚 $text';
      case 'ألعاب':
        return '🎮 $text'; // Added emoji for "ألعاب"
      default:
        return text;
    }
  }
}

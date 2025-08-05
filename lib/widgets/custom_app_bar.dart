import 'package:flutter/material.dart';
//import 'custom_drawer.dart'; // Import the custom drawer
import 'screens/sign_in_screen.dart'; // Import the sign-in screen
import 'screens/sign_up_screen.dart'; // Import the sign-up screen

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onDarkModeToggle;
  final VoidCallback onLanguageChange;
  final VoidCallback onChildModeToggle;
  final bool isChildModeActive;

  CustomAppBar({
    required this.onDarkModeToggle,
    required this.onLanguageChange,
    required this.onChildModeToggle,
    required this.isChildModeActive,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      title: Text('SoFlu', style: theme.textTheme.titleLarge),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Container(
            width: 24, // Width of the hamburger icon
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 3,
                  color: Colors.white, // Color of the hamburger lines
                ),
                SizedBox(height: 4), // Spacing between lines
                Container(
                  height: 3,
                  color: Colors.white, // Color of the hamburger lines
                ),
                SizedBox(height: 4), // Spacing between lines
                Container(
                  height: 3,
                  color: Colors.white, // Color of the hamburger lines
                ),
              ],
            ),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: Text('🔑',
              style: TextStyle(fontSize: 24)), // Cute emoji for login
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            );
          },
          color: theme
              .appBarTheme.titleTextStyle?.color, // Set icon color from theme
        ),
        IconButton(
          icon: Icon(Icons.person_add,
              size: 24), // Icon with a person and plus sign
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
          },
          color: theme
              .appBarTheme.titleTextStyle?.color, // Set icon color from theme
        ),
      ],
      backgroundColor:
          theme.appBarTheme.backgroundColor, // Set background color from theme
      elevation: theme.appBarTheme.elevation, // Set elevation from theme
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

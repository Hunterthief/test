import 'package:flutter/material.dart';

// Define themes
final ThemeData lightTheme = ThemeData(
  fontFamily: 'Comic Sans MS',
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Color(0xFFE0F7FA), // Light Cyan background
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff27a5b5), // Green background
    titleTextStyle: TextStyle(
      color: Color(0xfffdf6f6),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.lightBlueAccent, // Light Blue button
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlueAccent),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
      textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(fontSize: 26)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 36,
        color: Color(0xff27a5b5),
        letterSpacing: 2,
        fontFamily: 'Comic Sans MS'),
    displayMedium: TextStyle(
        fontSize: 30,
        color: Colors.lightBlueAccent,
        fontFamily: 'Comic Sans MS'),
    displaySmall: TextStyle(
        fontSize: 26, color: Color(0xff27a5b5), fontFamily: 'Comic Sans MS'),
  ),
  dividerColor: Colors.transparent,
  colorScheme: ColorScheme.light(
    primary: Color(0xff27a5b5),
    onPrimary: Colors.white,
  ),
);

final ThemeData darkTheme = ThemeData(
  fontFamily: 'Comic Sans MS',
  scaffoldBackgroundColor:
      Colors.transparent, // This will allow the gradient to show
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF5D6D7E), // Darker Gray button
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF5D6D7E)),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
      textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(fontSize: 26)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 36,
        color: Color(0xff27a5b5),
        letterSpacing: 2,
        fontFamily: 'Comic Sans MS'),
    displayMedium: TextStyle(
        fontSize: 30,
        color: Colors.lightBlueAccent,
        fontFamily: 'Comic Sans MS'),
    displaySmall: TextStyle(
        fontSize: 26, color: Color(0xff27a5b5), fontFamily: 'Comic Sans MS'),
  ),
  dividerColor: Colors.transparent,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF1F2A36),
    onPrimary: Colors.white,
  ),
);

// Define gradients as constants
final LinearGradient lightPrimaryGradient = LinearGradient(
  colors: [
    Color(0xffa18dd0), // Start color
    Color(0xff27a5b5), // End color
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient lightSecondaryGradient = LinearGradient(
  colors: [
    Color(0xff8167bc), // Start color
    Color(0xff5bf1e5),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient darkPrimaryGradient = LinearGradient(
  colors: [
    Color(0xFF3D0F5D), // Dark Purple
    Color(0xff100b55), // Black
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient darkSecondaryGradient = LinearGradient(
  colors: [
    Color(0xFF3D0F5D), // Dark Purple
    Color(0xff2519d0), // Black
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final LinearGradient darkModeContainerGradient = LinearGradient(
  colors: [
    Colors.deepPurple, // Lighter Dark Purple
    Color(0xff0f286b), // Dark Gray
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// Extension to add custom gradients to ThemeData
extension CustomThemeExtensions on ThemeData {
  CustomThemeData get customThemeData {
    return CustomThemeData(
      lightPrimaryGradient: lightPrimaryGradient,
      lightSecondaryGradient: lightSecondaryGradient,
      darkPrimaryGradient: darkPrimaryGradient,
      darkSecondaryGradient: darkSecondaryGradient,
      darkModeContainerGradient: darkModeContainerGradient,
    );
  }
}

// Create a class for custom gradients
class CustomThemeData {
  final LinearGradient lightPrimaryGradient;
  final LinearGradient lightSecondaryGradient;
  final LinearGradient darkPrimaryGradient;
  final LinearGradient darkSecondaryGradient;
  final LinearGradient darkModeContainerGradient;

  CustomThemeData({
    required this.lightPrimaryGradient,
    required this.lightSecondaryGradient,
    required this.darkPrimaryGradient,
    required this.darkSecondaryGradient,
    required this.darkModeContainerGradient,
  });
}

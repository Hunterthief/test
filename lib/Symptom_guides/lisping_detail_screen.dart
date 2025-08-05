import 'package:flutter/material.dart';

class LispingDetailScreen extends StatelessWidget {
  final String title;
  final String preFilledText;

  LispingDetailScreen({
    required this.title,
    required this.preFilledText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Display the title in the app bar
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black87
            : Colors.blue, // Adjust color based on theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: Text(
          preFilledText, // Display the raw text
          textAlign: TextAlign.right, // Align text to the right
          style: TextStyle(
            fontSize: 18, // Standard font size
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black, // Use black/white depending on theme
          ),
        ),
      ),
    );
  }
}

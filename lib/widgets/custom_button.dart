import 'package:flutter/material.dart';
//import '../theme.dart'; // Ensure this path is correct

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ElevatedButtonThemeData elevatedButtonTheme =
        theme.elevatedButtonTheme;

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: elevatedButtonTheme.style?.textStyle?.resolve({}) ?? TextStyle(),
      ),
      style: elevatedButtonTheme.style?.copyWith(
            backgroundColor: elevatedButtonTheme.style?.backgroundColor ??
                WidgetStateProperty.all<Color>(Colors.lightBlueAccent),
            foregroundColor: elevatedButtonTheme.style?.foregroundColor ??
                WidgetStateProperty.all<Color>(Colors.white),
            padding: elevatedButtonTheme.style?.padding ??
                WidgetStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 20, horizontal: 30)),
            shape: elevatedButtonTheme.style?.shape ??
                WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
          ) ??
          ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
    );
  }
}
